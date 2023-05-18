global class AccBatchOppTask implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id,Name,OwnerId from Account where Type=\'Prospect\' and CustomerPriority__c = \'High\'');
    }
    
    global void execute(Database.BatchableContext bc,List<sObject> accList){
        List<Opportunity> oppList = new List<Opportunity>();
        List<Task> taskList = new List<Task>();
        Id priceBookID = Test.getStandardPricebookId();
        for(Account acc : (List<Account>)accList){
            Opportunity op = new Opportunity();
            op.AccountId = acc.Id;
            op.Name = acc.Name + 'Opportunity BatchTest';
            op.StageName = 'Prospecting';
            op.CloseDate = Date.today().addDays(20);
            op.Pricebook2Id = priceBookID;
            oppList.add(op);
            
            Task t = new Task();
            t.Subject = acc.Name + 'Batch Task';
            t.ActivityDate = Date.today().addDays(7);
            t.OwnerId = acc.OwnerId;
            t.WhatId = op.Id;
            taskList.add(t);
            
        }
        if(accList.size()>0){
            insert oppList;
            insert taskList;
        }
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Batch Class executed successfully');
    }
}