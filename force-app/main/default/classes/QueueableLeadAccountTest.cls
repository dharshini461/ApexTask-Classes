@isTest
public class QueueableLeadAccountTest {
    
    @testSetup
    static void testData(){
        //Integer count = 10;
        Lead lead = TestDataFactory.createIndLead('Test Lead Queue');       
    }
    
    @isTest
    static void populateAddress(){
        /*Lead lead = [select id,Industry,Company,Street,City,State,PostalCode,Country from Lead where Company like 'CTS' limit 1];
        QueueableLeadAccount leaAcc = new QueueableLeadAccount(lead);
        Test.startTest();
        System.enqueueJob(leaAcc);
        Test.stopTest();*/
        Lead lead = [Select Company from Lead order by CreatedDate DESC LIMIT 1];
        System.assert([Select Id from Account where Name =: lead.Company].size()>0);
    }

}