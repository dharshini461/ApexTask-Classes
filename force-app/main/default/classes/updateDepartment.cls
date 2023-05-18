public class updateDepartment {

    public static void updAccountDepartment(){
        List<Account> updateAcc = new List<Account>();
        List<Account> accList = [SELECT Id,Industry FROM Account];
        for(Account acc : accList){
            if(acc.Industry == 'Education' || acc.Industry == 'Technology'){
                acc.Department__c = 'IT';
                updateAcc.add(acc);
            }
            else if(acc.Industry == 'Government'){
                acc.Department__c = 'HR';
                updateAcc.add(acc);
            }
            else if(acc.Industry == 'Construction' || acc.Industry == 'Finance'){
                acc.Department__c = 'Finance';
                updateAcc.add(acc);
            }
            else{
                acc.Department__c = '';
                updateAcc.add(acc);
            }
        }
        update updateAcc;
    }
    
}