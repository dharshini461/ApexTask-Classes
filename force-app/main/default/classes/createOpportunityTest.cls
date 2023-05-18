@isTest
public class createOpportunityTest {
    
    @testSetup
    public static void testData(){
        Integer count = 10;
        Account acc = TestDataFactory.createIndAccount('TestAccount');
        
    }
    
    @isTest
    public static void testcreateAccOppMethod1(){
        Account acc = [Select id,Name from Account where Name = 'TestAccount'];
        Opportunity Opportunity = TestDataFactory.createIndOpportunity(acc, 'TestOpp');
        Test.startTest();
        createOpportunity.createAccOpp();
        Test.stopTest();
    }
    
    @isTest
    public static void testcreateAccOppMethod2(){
        Account acc = [Select id,Name from Account where Name = 'TestAccount'];
        Test.startTest();
        createOpportunity.createAccOpp();
        Test.stopTest();
    }

}