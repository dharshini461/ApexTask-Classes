@isTest
public class accountFormatQueryTest {
    
    @testSetup
    public static void testData(){
        Account acc = TestDataFactory.createIndAccount('TestAcme Account');
        Lead led = TestDataFactory.createIndLead(acc,'TestAcme Lead');
    }
    
    @isTest
    public static void testfindString(){        
        Test.startTest();
        accountFormatQuery.findString();
        Test.stopTest();
    }

}