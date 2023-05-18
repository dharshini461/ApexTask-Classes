public class AssetTriggerHandler {

    public static void populateAccAssetExpDate(List<Asset> assList){
        List<Account> accList = new List<Account>();
        for(Asset ass : assList){
            Account acc = [Select Id,Asset_Minimum_Expiration_Date__c from Account where Id =: ass.AccountId];
            if(acc.Asset_Minimum_Expiration_Date__c != ass.UsageEndDate){
                acc.Asset_Minimum_Expiration_Date__c = ass.UsageEndDate;
                accList.add(acc);
            }
        }
        Database.SaveResult[] result = Database.update(accList,true);
        System.debug(result);
    }
}