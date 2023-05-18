public class createOpportunity {
    
    public static void createAccOpp(){
        List<Account> accList = [SELECT Id,Name FROM Account WHERE Active__c = 'yes'];
        List<Opportunity> updateOppList = new List<Opportunity>();
        List<Opportunity> newOppList = new List<Opportunity>();
        for(Account acc : accList){
            List<Opportunity> oppList = [SELECT Id,StageName FROM Opportunity where AccountId =: acc.Id];
            if(oppList.size()>0){
                for(Opportunity op : oppList){
                    op.StageName = 'Prospecting';
                    updateOppList.add(op);
                }
            }
            else{
                Opportunity op = new Opportunity();
                op.AccountId = acc.Id;
                op.Name = acc.Name + ' Opp ';
                op.CloseDate = Date.today()+5;
                op.StageName = 'Prospecting';
                newOppList.add(op);
            }
        }
        Database.SaveResult[] result = Database.update(updateOppList,true);
        System.debug(result);
        result = Database.insert(newOppList,true);
        System.debug(result);
    }

}