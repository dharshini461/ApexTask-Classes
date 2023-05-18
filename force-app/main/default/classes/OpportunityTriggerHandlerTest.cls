@isTest(seeAllData = false)
public class OpportunityTriggerHandlerTest {
    
    @testSetup
    static void testSetup(){
        Account acc = TestDataFactory.createIndAccount('TestAccount');
        Opportunity opp = TestDataFactory.createIndOpportunity(acc,'Test Opportunity');
    }
    
    @isTest
    static void testsendEmailOnOppChange(){
        Opportunity opp = [Select Id,Name,StageName from Opportunity where Name =: 'Test Opportunity' LIMIT 1];
        List<Opportunity> oppList = new List<Opportunity>();
        oppList.add(opp);
        Map<Id, Opportunity> oppOldList = new Map<Id, Opportunity>(oppList);
        Test.startTest();
        OpportunityTriggerHandler.sendEmailOnOppChange(oppList, oppOldList);
        Test.stopTest();
	}
    
    @isTest
    static void testOpportunityItemListInsert(){
         Opportunity opp = [Select Id,(Select Id from OpportunityLineItems) from Opportunity where Name =: 'Test Opportunity' LIMIT 1];
         opp.Pricebook2Id = Test.getStandardPricebookId();
         update opp;
         List<Opportunity> oppList = new List<Opportunity>();
         oppList.add(opp);
         Test.startTest();
         OpportunityTriggerHandler.OpportunityItemListInsert(oppList);
         Test.stopTest();
    }
        

}