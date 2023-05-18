public class expireAndIndustry {
    
    public static void getAccounts(){
        List<Account> industryValue = [SELECT Id,Industry,SLAExpirationDate__c,Active__c FROM Account WHERE SLAExpirationDate__c > today and Industry = 'Energy'];
        List<Account> accList = new List<Account>();
        System.debug('---List of Industries---'+accList);
        for(Account acc:industryValue){
            if(acc.Active__c != 'No'){
                acc.Active__c = 'No';
                accList.add(acc);
            }
            System.debug('---ID---'+acc.Id);
            System.debug('---Name---'+acc.Name);
            System.debug('---Industry---'+acc.Industry);
            System.debug('---SLAExpirationDate__c---'+acc.SLAExpirationDate__c);
        }
        if(accList.size() > 0){
        	update accList; 
        }
        
    }

}