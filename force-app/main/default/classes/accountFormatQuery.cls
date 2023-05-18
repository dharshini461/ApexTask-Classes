public class accountFormatQuery {

    public static void findString(){
        String searchstr = 'Acme';
        System.debug('---Account Records---');
        for(Account acc : [SELECT Name from Account where Name Like : ('%'+searchstr+'%')]){
            System.debug(acc.Name);
        }
        System.debug('---Lead Records---');
        for(Lead lead : [SELECT Name from Lead where Name Like : ('%'+searchstr+'%')]){
            System.debug(lead.Name);
        }
    }
    
}