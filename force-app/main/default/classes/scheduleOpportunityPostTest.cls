@isTest
public class scheduleOpportunityPostTest {

    @testSetup
    public static void testData(){
        List<Product2> pdList = TestDataFactory.createProduct(1);
        List<PriceBookEntry> priceList = TestDataFactory.createPriceBookEntry(pdList[0],1);
        List<Account> accList = TestDataFactory.createAccount(3);
        List<Opportunity> oppList = TestDataFactory.createOpportunity(accList[0],1);
        oppList[0].Amount = 10000000;
        oppList[0].StageName = 'Closed Won';
        update oppList[0];
    }
    
    @isTest
    public static void testscheduleOpportunityPost(){
        String CRON_EXP = '0 0 23 * * ?';
        Test.startTest();
        String jobId = System.schedule('Schedule Opportunity Post', CRON_EXP, new scheduleOpportunityPost());
        Test.stopTest();
        System.assert([SELECT body from FeedItem].size()>0);
    }
}