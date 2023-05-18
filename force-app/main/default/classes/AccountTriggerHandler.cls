public with sharing class AccountTriggerHandler {
    
    public static void populateShippingAddressOnAccount(List<Account> acclist){
        for(Account acc : acclist){
            if(acc.BillingStreet != null){
                acc.ShippingStreet = acc.BillingStreet;
            }
            if(acc.BillingCity != null){
                acc.ShippingCity = acc.BillingCity;
            }
            if(acc.BillingState != null){
                acc.ShippingState = acc.BillingState;
            }
            if(acc.BillingPostalCode != null){
                acc.ShippingPostalCode = acc.BillingPostalCode;
            }
            if(acc.BillingCountry != null){
                acc.ShippingCountry = acc.BillingCountry;
            }
        }
    }
    
    public static void oppStageOnAccUpdate(List<Account> acclist){
        Set<Id> accId = new Set<Id>();
        for(Account acc : acclist){
            accId.add(acc.Id);
        }
        List<Opportunity> oppList = [Select Id,AccountId,StageName,CreatedDate,CloseDate from Opportunity where AccountId in: accId];
        List<Opportunity> oppUpdate = new List<Opportunity>();
        DateTime day_thirty = System.now()-30;
        if(oppList.size()>0){
            for(Opportunity op : oppList){
                if(op.CreatedDate < day_thirty && op.StageName != 'Closed Won'){
                    op.StageName = 'Closed Lost';
                    op.CloseDate = System.today();
                    oppUpdate.add(op);
                }
            }
        }
        if(oppUpdate.size()>0){
            update oppUpdate;
        }
    }
    
    public static void clientContactAcc(List<Account> accnewlist){
        List<Account> accupdateList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        Map<Id,Account> accUpdate = new Map<Id,Account>();
        Set<Id> accId = new Set<Id>();
        for(Account a : accnewlist){
            accId.add(a.Id);
            Contact c = new Contact();
            c.LastName = a.Name;
            c.AccountId = a.Id;
            conList.add(c);
        }
        if(conList.size()>0){
            insert conList;
        }
        List<Account> accList = [SELECT ID,Client_Contact__c from Account where id =: accId];
        if(accList.size()>0){
            for(Account a: accList){
                accUpdate.put(a.Id, a);
            }
        }
        if(conList.size()>0){
            for(Contact c : conList){
                if(accUpdate.containsKey(c.AccountId)){
                    Account a = accUpdate.get(c.AccountId);
                    a.Client_Contact__c = c.Id;
                    accupdateList.add(a);
                }
            }
        }
        if(accupdateList.size()>0){
            update accupdateList;
        }
    }
    
    public static void sendEmailToAdminonAcc(List<Account> accnewlist){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        User admin = [SELECT Id,Profile.Name,Email from User where Profile.Name='System Administrator'];
        for(Account acc : accnewlist){
            if(admin.Email != null){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setSenderDisplayName('Apex Salesforce');
                mail.setUseSignature(false);
                mail.setBccSender(false);
                mail.setSaveAsActivity(false);
                mail.toaddresses = new String[]{admin.Email};
                mail.setSubject('New Account was Created.');
                String body = 'Dear System Administrator, <br/>An account has been created and name is '+acc.Name+'.';
                mail.setHtmlBody(body);
                mails.add(mail);
                
            }
        }
        if(mails.size()>0){
            Messaging.SendEmailResult[] results = Messaging.SendEmail(mails);
            if(results[0].success){
                System.debug('The email was sent successfully.');
            }
            else{
                System.debug('The email failed to send:'+results[0].errors[0].message);
            }
        }
    }
    
    public static void updateTotalOppOnAcc(List<Account> accnewlist){
        Set<Id> accountId = new Set<Id>();
        Map<Id, Double> accOppAmt = new Map<Id, Double>();
        for(Account acc : accnewlist){
            acc.Total_Opportunity_Amount__c = 0;
            accountId.add(acc.Id);
        }
        List<AggregateResult> results = [Select AccountId,sum(Amount)TotalAmount from Opportunity where AccountId in: accountId group by AccountId];
        if(results.size()>0){
            for(AggregateResult res: results){
                Id accId = (ID)res.get('AccountId');
                double TotalAmount = (double)res.get('TotalAmount');
                accOppAmt.put(accId,TotalAmount);
            }
        }
        for(Account acc : accnewlist){
            if(accOppAmt.containsKey(acc.Id)){
                acc.Total_Opportunity_Amount__c = accOppAmt.get(acc.Id);
            }
        }        
    }
    
    public static void sendEmailOnAccTypeChange(List<Account> accnewlist, Map<Id, Account> accOldMaplist){
        Set<Id> accId = new Set<Id>();
        for(Account acc: accnewlist){
            if(acc.Type != accOldMaplist.get(acc.Id).Type){
                accId.add(acc.Id);
            }
        }
        List<Contact> conList = [SELECT Id,LastName,Email,AccountId,Account.Name from Contact where AccountId=:accId];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        if(conList.size()>0){
            for(Contact con : conList){
                if(con.Email!=null){
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setTargetObjectId(con.Id);
                    mail.setSenderDisplayName('Contact Account');
                    mail.setUseSignature(false);
                    mail.setBccSender(false);
                    mail.setSaveAsActivity(false);
                    mail.setSubject('Account Update Info.');
                    String body = 'Dear '+con.LastName+' <br> Your account information has been updated successfully.<br/>Accont Name : '+con.Account.Name;
                    mail.setHtmlBody(body);
                    mail.toaddresses = new String[]{con.Email};
                    mails.add(mail);
                }
            }
        }
        if(mails.size()>0){
            Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
            if(results[0].success){
                System.debug('The email was sent successfully.');
            }
            else{
                System.debug('The email failed to send:'+results[0].errors[0].message);
            }
        }
    }
    
    public static void checkNameCharacter(List<Account> accnewlist){
        for(Account acc : accnewlist){
            if(acc.Name.length() > 50){
                acc.Name.addError('Account Name Max Length is 50 characters');
            }           
        }
    }
    
    public static void noEmployandSource(List<Account> accnewlist){
        for(Account acc : accnewlist){
            if(acc.NumberOfEmployees == 0 || acc.NumberOfEmployees == null){
                acc.NumberOfEmployees=10;
            }
            acc.AccountSource = 'Web';
        }
    }
    
    public static void noOfEmpType(List<Account> accnewlist){
        for(Account acc : accnewlist){
            if(acc.NumberOfEmployees>=100 && acc.NumberOfEmployees<=10000){
                acc.Type_of_Account__c = 'Bronze';
            }
            else if(acc.NumberOfEmployees >= 10001 && acc.NumberOfEmployees <= 50000){
                acc.Type_of_Account__c = 'Gold';
            }
            else if(acc.NumberOfEmployees>=50001){
                acc.Type_of_Account__c = 'Platinum';
            }
            else{
                acc.Type_of_Account__c = '';
            }
        }
    }
    
    public static void accContainsTest(List<Account> accnewlist){
        for(Account acc : accnewlist){
            if(acc.Name.containsIgnoreCase('Test')){
                acc.Industry = 'Other';
                acc.Description = 'This account created for testing purpose.';
            }
        }
    }
    
    public static void createContact5(List<Account> accnewlist){
        List<Contact> conList = new List<Contact>();
        for(Account acc : accnewlist){
            for(Integer i=1;i<=5;i++){
                Contact con = new Contact();
                con.AccountId = acc.Id;
                con.LastName = acc.Name + 'Contact '+i;
                conList.add(con);
            }
        }
        if(conList.size()>0){
            insert conList;
        }
    }
    
    public static void setAnnualRevenue(List<Account> accnewlist){
        for(Account acc : accnewlist){
            if(acc.Active__c == 'Yes' && (acc.AnnualRevenue == null || acc.AnnualRevenue == 0)){
                acc.AnnualRevenue=500000;
            }
        }
    }
    
    public static void setMailingCityOnContact(List<Account> accnewlist,  Map<Id, Account> accOldMaplist){
        Set<Id> accId = new Set<Id>();
        for(Account acc : accnewlist){
            if(acc.BillingCity != null && acc.BillingCity != accOldMaplist.get(acc.Id).BillingCity){
                accId.add(acc.Id);
            }
        }
        List<Contact> conUpdate = new List<Contact>();
        List<Contact> conList = [Select Id,MailingCity,AccountId,Account.BillingCity from Contact where AccountId=:accId];
        if(conList.size()>0){
            for(Contact con : conList){
                if(con.MailingCity != con.Account.BillingCity){
                    con.MailingCity = con.Account.BillingCity;
                    conUpdate.add(con);
                }
            }
        }
        if(conUpdate.size()>0){
            update conUpdate;
        }
    }

}