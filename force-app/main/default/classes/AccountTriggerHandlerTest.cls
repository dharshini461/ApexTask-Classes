@isTest(seeAllData=false)
public class AccountTriggerHandlerTest {
    
    @testSetup
    static void testSetup(){
        Account acc = TestDataFactory.createIndAccount('TestAccount');
        Opportunity opp = TestDataFactory.createIndOpportunity(acc,'Test Opportunity');
    }
    
    @isTest
    static void testpopulateShippingAddressOnAccount(){
        Account acc = [Select Id,Name,BillingStreet,BillingCity,BillingCountry,BillingState,BillingPostalCode from Account where Name =: 'TestAccount' LIMIT 1];
        List<Account> accList = new List<Account>();
        accList.add(acc);
        Test.startTest();
        AccountTriggerHandler.populateShippingAddressOnAccount(accList);
        Test.stopTest();
    }
    
    @isTest
    static void testoppStageOnAccUpdate(){
        Account acc = [Select Id,Name from Account where Name =: 'TestAccount' LIMIT 1];
        Opportunity opp = [Select Id,Name from Opportunity where Name =: 'Test Opportunity' LIMIT 1];
        List<Account> accList = new List<Account>();
        accList.add(acc);
        Test.startTest();
        AccountTriggerHandler.oppStageOnAccUpdate(accList);
        Test.stopTest();
    }
    
    @isTest
    static void testclientContactAcc(){
        Account acc = [Select Id,Name from Account where Name =: 'TestAccount' LIMIT 1];
        List<Account> accList = new List<Account>();
        accList.add(acc);
        Test.startTest();
        AccountTriggerHandler.clientContactAcc(accList);
        Test.stopTest();
	}
    
    @isTest
    static void testsendEmailToAdminonAcc(){
        Account acc = [Select Id,Name from Account where Name =: 'TestAccount' LIMIT 1];
        List<Account> accList = new List<Account>();
        accList.add(acc);
        Test.startTest();
        AccountTriggerHandler.sendEmailToAdminonAcc(accList);
        Test.stopTest();
	}
    
    @isTest
    static void testupdateTotalOppOnAcc(){
        Account acc = [Select Id,Name from Account where Name =: 'TestAccount' LIMIT 1];
        List<Account> accList = new List<Account>();
        accList.add(acc);
        Test.startTest();
        AccountTriggerHandler.updateTotalOppOnAcc(accList);
        Test.stopTest();
	}
    
    @isTest
    static void testsendEmailOnAccTypeChange(){
        Account acc = [Select Id,Name,Type from Account where Name =: 'TestAccount' LIMIT 1];
        List<Account> accList = new List<Account>();
        accList.add(acc);
        Map<Id, Account> accOldList = new Map<Id, Account>(accList);
        Test.startTest();
        AccountTriggerHandler.sendEmailOnAccTypeChange(accList, accOldList);
        Test.stopTest();
	}
    
    @isTest
    static void testcheckNameCharacter(){
        Account acc = [Select Id,Name from Account where Name = 'TestAccount' LIMIT 1];
        acc.Name = 'TestAccountTestAccountTestAccountTestAccountTestAccount';
        Test.startTest();
        try{
        	update acc;
        }catch(Exception e){
            System.assert(e.getMessage().contains('Account Name Max Length is 50 characters'));
        }
		Test.stopTest();
        /*List<Account> accList = new List<Account>();
        accList.add(acc);
        Test.startTest();
        System.debug('Acc TEST CHAR ---'+acc.Name);
        AccountTriggerHandler.checkNameCharacter(accList);
        Test.stopTest();*/
	}
    
    @isTest
    static void testnoEmployandSource(){
        Account acc = [Select Id,Name,NumberOfEmployees,AccountSource from Account where Name = 'TestAccount' LIMIT 1];
        List<Account> accList = new List<Account>();
        accList.add(acc);
        Test.startTest();
        AccountTriggerHandler.noEmployandSource(accList);
        Test.stopTest();
        System.assertEquals('Web', acc.AccountSource);
        System.assertEquals(10, acc.NumberOfEmployees);
	}
    
    @isTest
    static void testnoOfEmpType(){
        Account acc = [Select NumberOfEmployees from Account where Name = 'TestAccount' LIMIT 1];
        acc.NumberOfEmployees = 50001;
        Account acc1 = [Select NumberOfEmployees from Account where Name = 'TestAccount' LIMIT 1];
        acc1.NumberOfEmployees = 10000;
        Account acc2 = [Select NumberOfEmployees from Account where Name = 'TestAccount' LIMIT 1];
        acc2.NumberOfEmployees = 50000;
        List<Account> accList = new List<Account>();
        accList.add(acc);
        accList.add(acc1);
        accList.add(acc2);
        Test.startTest();
        AccountTriggerHandler.noOfEmpType(accList);
        Test.stopTest();
        
	}
    
    @isTest
    static void testaccContainsTest(){
        Account acc = [Select Id,Name from Account where Name = 'TestAccount' LIMIT 1];
        List<Account> accList = new List<Account>();
        accList.add(acc);
        Test.startTest();
        AccountTriggerHandler.accContainsTest(accList);
        Test.stopTest();
	    acc = [Select Industry, Description from Account where Name = 'TestAccount' LIMIT 1];
		System.assertEquals('Other', acc.Industry);
		System.assertEquals('This account created for testing purpose.', acc.Description);
	}
    
    @isTest
    static void testcreateContact5(){
        Account acc = [Select Id,Name from Account where Name = 'TestAccount' LIMIT 1];
        List<Account> accList = new List<Account>();
        accList.add(acc);
        Test.startTest();
        AccountTriggerHandler.createContact5(accList);
        //System.assertEquals(5, [Select Count() from Contact where AccountId = :acc.Id]);
        Test.stopTest();
	}
    
    @isTest
    static void testsetAnnualRevenue(){
        Account acc = [Select Id,Name,Active__c from Account where Name = 'TestAccount' LIMIT 1];
        acc.AnnualRevenue = 0;
        List<Account> accList = new List<Account>();
        accList.add(acc);
        Test.startTest();
        AccountTriggerHandler.setAnnualRevenue(accList);
        Test.stopTest();
        System.assertEquals(500000, acc.AnnualRevenue);
	}
    
    @isTest
    static void testsetMailingCityOnContact(){
        Account acc = [Select Id,Name,BillingCity from Account where Name =: 'TestAccount' LIMIT 1];
        List<Account> accList = new List<Account>();
        accList.add(acc);
        Map<Id, Account> accOldList = new Map<Id, Account>(accList);
        Test.startTest();
        AccountTriggerHandler.setMailingCityOnContact(accList, accOldList);
        Test.stopTest();
	}

}