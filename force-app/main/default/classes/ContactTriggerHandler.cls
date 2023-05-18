public with sharing class ContactTriggerHandler {

    public static void sendEmailOnContactInsertHandler(List<Contact> newContact){
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        EmailTemplate emailTemp = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name='Email Template to send After Contact is Inserted'];
        for(Contact con : newContact){
            if(con.Email != null){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setTargetObjectId(con.Id);
                    mail.setSenderDisplayName('Account Contact');
                    mail.setUseSignature(false);
                    mail.setBccSender(false);
                    mail.setTemplateId(emailTemp.Id);
                    mail.setSaveAsActivity(false);
                    mail.toaddresses = new String[]{con.Email};
                    mails.add(mail);
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
    
    public static void preventDupliConInsertHandler(List<Contact> newContact,Map<Id, Contact> newConMap){
        Map<String, Contact> emailMap = new Map<String, Contact>();
        Map<String, Contact> phoneMap = new Map<String, Contact>();
        for(Contact con: newContact){
                emailMap.put(con.Email,con);
                phoneMap.put(con.Phone,con);          
        }
        String errorMessage='';
        List<Contact> existingContactList = [Select Id,Email,Phone from Contact where Email in:emailMap.keySet() or Phone in:phoneMap.keySet()];
        if(existingContactList.size()>0){
            for(Contact con : existingContactList){
                if(con.Email != null){
                    if(emailMap.get(con.Email) != null){
                        errorMessage='Email';
                    }
                }
                if(con.Phone != null){
                    if(phoneMap.get(con.Phone) != null){
                        errorMessage = errorMessage + (errorMessage != ''? ' and Phone' : 'Phone ');
                    }
                }
                if(errorMessage != ''){
                    newContact[0].addError('Your Contact '+errorMessage+' already exists in system');
                }
            }
        }
    }
    
    public static void preventDupliConUpdateHandler(List<Contact> newContact,Map<Id, Contact> oldConMap){
        Map<String, Contact> emailMap = new Map<String, Contact>();
        Map<String, Contact> phoneMap = new Map<String, Contact>();
        for(Contact con: newContact){            
            if(oldConMap.get(con.Id).Email != con.Email){
                emailMap.put(con.Email,con);
            }
            if(oldConMap.get(con.Id).Phone != con.Phone){
                phoneMap.put(con.Phone,con);
            }          
        }
        String errorMessage='';
        List<Contact> existingContactList = [Select Id,Email,Phone from Contact where Email in:emailMap.keySet() or Phone in:phoneMap.keySet()];
        if(existingContactList.size()>0){
            for(Contact con : existingContactList){
                if(con.Email != null){
                    if(emailMap.get(con.Email) != null){
                        errorMessage='Email';
                    }
                }
                if(con.Phone != null){
                    if(phoneMap.get(con.Phone) != null){
                        errorMessage = errorMessage + (errorMessage != ''? 'and Phone' : 'Phone ');
                    }
                }
                if(errorMessage != ''){
                    trigger.new[0].addError('Your Contact '+errorMessage+' already exists in system');
                }
            }
        }
    }
    
}