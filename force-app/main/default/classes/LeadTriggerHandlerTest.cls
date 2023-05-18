@isTest(seeAllData=false)
public class LeadTriggerHandlerTest {
    
    @testSetup
    static void testSetup(){
        Account acc = TestDataFactory.createIndAccount('TestAccount');
        Lead l = TestDataFactory.createIndLead('TestLead');
    }
    
    @isTest
    public static void testduplicateLead(){
        Account acc = [Select id,name from Account where Name =:'TestAccount'];
        Lead l = [Select LastName,Company from Lead where LastName =:'TestLead' LIMIT 1];
        List<Lead> LeadList = new List<Lead>();
        LeadList.add(l);        
        Test.startTest();
        LeadTriggerHandler.afterInsert(LeadList);
        Test.stopTest();
        
    }

}