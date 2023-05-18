@isTest
public class expireAndIndustryTest {
    
    @testSetup
    public static void testData(){
        Integer count = 10;
        Account acc = TestDataFactory.createIndAccount('Test Account');
    }
    
    @isTest
    public static void testgetAccounts(){
        Account acc = [Select Id from Account where Name = 'Test Account' LIMIT 1];
        acc.Industry = 'Energy';
        acc.SLAExpirationDate__c = Date.today()+5;
        acc.Active__c = 'Yes';
        Test.startTest();
        expireAndIndustry.getAccounts();
        Test.stopTest();
    }

}