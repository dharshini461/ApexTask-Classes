@isTest(seeAllData=false)
public class AssetTriggerHandlerTest {
    
    @testSetup
    static void testSetup(){
        Account acc = TestDataFactory.createIndAccount('TestAccount');
        Asset ass = TestDataFactory.createIndAsset(acc,'Test Asset');
    }
    
    @isTest
    static void testpopulateAccAssetExpDate(){
        Account acc = [Select Id from Account where Name =: 'TestAccount' LIMIT 1];
        Asset ass = [Select Id,Name,UsageEndDate,AccountId from Asset where Name =: 'Test Asset' and AccountId =: acc.Id LIMIT 1];
        List<Asset> assList = new List<Asset>();
        assList.add(ass);
        Test.startTest();
        AssetTriggerHandler.populateAccAssetExpDate(assList);
        Test.stopTest();
	}

}