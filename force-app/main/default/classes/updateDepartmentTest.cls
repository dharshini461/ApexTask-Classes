@isTest
public class updateDepartmentTest {
    
    @testSetup
    public static void testData(){
        Integer count = 10;
        List<Account> accList = TestDataFactory.createAccount(count);
    }
    
    @isTest
    public static void tesupdAccountDeptFinance(){
        List<Account> accList = [Select Id,Industry from Account where Name like 'TestAccount%' LIMIT 10];
        List<Account> accUpdate = new List<Account>();
        for(Account acc : accList){
            acc.Industry = 'Finance';
            accUpdate.add(acc);
        }
        update accUpdate;
        Test.startTest();
        updateDepartment.updAccountDepartment();
        Test.stopTest();
    }
    
    @isTest
    public static void tesupdAccountDeptEducation(){
        List<Account> accList = [Select Id,Industry from Account where Name like 'TestAccount%' LIMIT 10];
        List<Account> accUpdate = new List<Account>();
        for(Account acc : accList){
            acc.Industry = 'Education';
            accUpdate.add(acc);
        }
        update accUpdate;
        Test.startTest();
        updateDepartment.updAccountDepartment();
        Test.stopTest();
    }
    
    @isTest
    public static void tesupdAccountDeptGovernment(){
        List<Account> accList = [Select Id,Industry from Account where Name like 'TestAccount%' LIMIT 10];
        List<Account> accUpdate = new List<Account>();
        for(Account acc : accList){
            acc.Industry = 'Government';
            accUpdate.add(acc);
        }
        update accUpdate;
        Test.startTest();
        updateDepartment.updAccountDepartment();
        Test.stopTest();
    }
    
    @isTest
    public static void tesupdAccountDeptNull(){
        List<Account> accList = [Select Id,Industry from Account where Name like 'TestAccount%' LIMIT 10];
        List<Account> accUpdate = new List<Account>();
        for(Account acc : accList){
            acc.Industry = '';
            accUpdate.add(acc);
        }
        update accUpdate;
        Test.startTest();
        updateDepartment.updAccountDepartment();
        Test.stopTest();
    }

}