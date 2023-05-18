@isTest(seeAllData=false)
public class TaskTriggerHandlerTest {
    
    @testSetup
    static void testSetup(){
        Account acc = TestDataFactory.createIndAccount('TestAccount');
        Contact con = TestDataFactory.createIndContact(acc,'TestCts');
        Task t = TestDataFactory.createIndTask(acc,con);
        User u = TestDataFactory.createUser();
    }

    @isTest
    static void testdeletetaskbyAdminHandler(){
        Account acc = [Select id,name from Account where Name =:'TestAccount'];
        User user = [Select id,ProfileID from User LIMIT 1];
        Task t = [Select id,Status from Task where Status =: 'In Progress' LIMIT 1];
        List<Task> taskList = new List<Task>();
        taskList.add(t);   
        System.runAs(user){
            Test.startTest();
       		TaskUtility.deletetaskbyAdminHandler(taskList);
        	Test.stopTest();
        }       
    }
}