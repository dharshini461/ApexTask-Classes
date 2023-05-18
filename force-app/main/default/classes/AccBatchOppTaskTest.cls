@isTest(seeAllData=false)
public class AccBatchOppTaskTest {

    @testSetup 
    static void testData(){
        Integer count = 10;
        List<Account> accList = TestDataFactory.createAccount(count);     
    }
    
    @isTest
    static void createOppAndTask(){
        Test.startTest();
        AccBatchOppTask accBt = new AccBatchOppTask();
        Id batchId = Database.executeBatch(accBt);
        Test.stopTest();
        System.assertEquals(10, [select count() from Account where Type = 'Prospect' and CustomerPriority__c = 'High']);
    }
}