public with sharing class OpportunityTriggerHandler {

    public static void sendEmailOnOppChange(List<Opportunity> oppnewlist,Map<Id, Opportunity> oppOldMapList){
        Set<Id> oppId = new Set<Id>();    
        for(Opportunity op : oppnewlist){
            oppId.add(op.Id);       
        }
        
        List<Opportunity> oppList = [Select Id,Account.Client_Contact__r.Email,Account.Client_Contact__r.LastName, Account.Client_Contact__c from Opportunity where Id=:oppId];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for(Opportunity o : oppnewlist){
            if(o.StageName != oppOldMapList.get(o.Id).StageName && o.AccountId != null ){
                String sendto = o.Account.Client_Contact__r.Email;
                if(sendto != null){
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setTargetObjectId(o.Account.Client_Contact__c);
                    mail.setSenderDisplayName('Opportunity Account Contact');
                    mail.setUseSignature(false);
                    mail.setBccSender(false);
                    mail.setSaveAsActivity(false);
                    mail.setSubject('Opportunity Account Update Info.');
                    String body = 'Dear '+o.Account.Client_Contact__r.LastName+'<br/> Your account information has been updated successfully.';
                    mail.setHtmlBody(body);
                    mail.toaddresses = new String[]{sendto};
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
    
    public static void OpportunityItemListInsert(List<Opportunity> oppList){
        PriceBookEntry pbe = [Select Id,UnitPrice from PriceBookEntry order by CreatedDate DESC LIMIT 1];
        List<OpportunityLineItem> oppProduct = new List<OpportunityLineItem>();
        for(Opportunity opp : oppList){
            OpportunityLineItem oppProd = new OpportunityLineItem();
            oppProd.OpportunityId = opp.Id;
            oppProd.Quantity = 1;
            oppProd.PricebookEntryId = pbe.Id;
            oppProd.TotalPrice = oppProd.Quantity * pbe.UnitPrice;
            oppProduct.add(oppProd);
        }
        if(oppProduct.size()>0){
            insert oppProduct;
        }
    }
}