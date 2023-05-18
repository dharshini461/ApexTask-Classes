@isTest
public class countIndustryTest {
	
    @testSetup
    public static void testData(){
        Integer count = 10;
        List<Account> accList = TestDataFactory.createAccount(count);
    }
    
    @isTest
    public static void testeachIndustryCount(){
        List<Account> accList = [SELECT Id,Industry from Account where Industry = 'Energy'];
        Test.startTest();
        countIndustry.eachIndustryCount();
        Test.stopTest();
    }
}