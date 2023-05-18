@isTest(seeAllData=false)
public class ContactTriggerHandlerTest {

    @testSetup
    static void testSetup(){
        EmailTemplate emailtemp = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name='Email Template to send After Contact is Inserted'];
        Account acc = TestDataFactory.createIndAccount('TestAccount');
        Contact con = TestDataFactory.createIndContact(acc,'TestCts');
    }
    
    @isTest
    static void testsendEmailOnContactInsertHandler(){
        Contact con = [Select Id,Email from Contact where LastName =: 'TestCts'];
        List<Contact> conList = new List<Contact>();
        conList.add(con);        
        Test.startTest();
        ContactTriggerHandler.sendEmailOnContactInsertHandler(conList);
        Test.stopTest();
        
    }
    
    @isTest
    static void testpreventDupliConInsertHandler(){
        Contact con = [Select Id,Email,Phone from Contact where LastName =: 'TestCts'];
        con.Phone = '6379966185';
        con.Email = 'dharshini.a2@cognizant.com';
        update con;
        List<Contact> conList = new List<Contact>();
        conList.add(con);  
        Map<Id, Contact> newCon = new Map<Id, Contact>();
        newCon.put(con.Id,con);
        Test.startTest();
        ContactTriggerHandler.preventDupliConInsertHandler(conList,newCon);
        Test.stopTest();
        
    }
    
    @isTest
    static void testpreventDupliConUpdateHandler(){
        Contact con = [Select Id,Email,Phone from Contact where LastName =: 'TestCts'];
        con.Phone = '6379966185';
        con.Email = 'dharshini.a2@cognizant.com';
        update con;
        List<Contact> conList = new List<Contact>();
        conList.add(con);  
        Map<Id, Contact> oldCon = new Map<Id, Contact>();
        oldCon.put(con.Id,con);
        Test.startTest();
        ContactTriggerHandler.preventDupliConUpdateHandler(conList,oldCon);
        Test.stopTest();
        
    }
}