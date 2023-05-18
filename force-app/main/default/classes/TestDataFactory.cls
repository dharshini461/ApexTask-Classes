@isTest
public class TestDataFactory {
    
    //AccountIndividual
    public static Account createIndAccount(String Name){
        Account acc = new Account();
        acc.Name = Name;
        acc.Phone = '6758990355';
        acc.Active__c = 'Yes';      
        acc.BillingStreet = '28,Nethaji Street';
        acc.BillingCity = 'Erode';
        acc.BillingCountry = 'India';
        acc.BillingState = 'TN';
        acc.BillingPostalCode = '638009';   
        acc.Type = 'Prospect';
        acc.Asset_Minimum_Expiration_Date__c = Date.today();
        //acc.NumberOfEmployees = 0;
        //acc.Industry = 'Energy';
        insert acc;
        return acc;
    }
    
    //AccountList
    public static List<Account> createAccount(Integer count){
        List<Account> accList = new List<Account>();
        for(integer i=1;i<=count;i++){
            Account acc = new Account();
            acc.Name = 'TestAccount '+ i;
            acc.Phone = '6758990355';
            acc.Active__c = 'Yes';
            acc.Type = 'Prospect';
            //acc.Industry = 'Energy';
            acc.CustomerPriority__c = 'High';
            //acc.SLAExpirationDate__c = Date.today()+5;
            accList.add(acc);
        }
        insert accList;
        return accList;
    }
    
    //ContactIndividual
    public static Contact createIndContact(Account acc,String Name){
        Contact con = new Contact();
        con.LastName = Name;
        Integer randomValue = Integer.valueOf(Math.random()+99);
        con.Email = 'testemailind'+randomValue+'@gmail.com';
        con.AccountId = acc.Id;
        insert con;
        return con;
    }
    
    //ConatctList
    public static List<Contact> createContact(Account acc,Integer count){
        List<Contact> conList = new List<Contact>();
        for(integer i=1;i<=count;i++){
            Contact con = new Contact();
            con.LastName = acc.Name+' Contact '+ i;
            con.Email = 'testemail'+i+'@gmail.com';
            con.AccountId = acc.Id;
            conList.add(con);
        }
        insert conList;
        return conList;
    }
    
    //Task
    public static Task createIndTask(Account acc,Contact con){
        Task t = new Task();
        t.Status = 'In Progress';
        t.Subject = 'Send Letter';
        t.Priority = 'Normal';
        t.WhoId = con.OwnerId;
        insert t;
        return t;
    }
    
    //Lead
    public static Lead createIndLead(String Name){
        Lead l = new Lead();
        l.LastName = Name;
        l.Company = 'CTS';
        l.Status = 'Open - Not Contacted';
        l.Industry = 'CONIO Industry';
        l.Street = 'Street1';
        l.City = 'Erd';
        l.Country = 'IND';
        l.State = 'TN';
        l.PostalCode = '638009';
        insert l;
        return l;
    }
    
    //LeadList
    public static List<Lead> createLead(Integer count){
        List<Lead> leadList = new List<Lead>();
        for(integer i=1;i<=count;i++){
            Lead lead = new Lead();
            lead.LastName = 'Test Lead '+i;
            lead.Company = 'CTS';
            lead.Industry = 'CONIO Industry';
            lead.Status = 'Open - Not Contacted';
            lead.Street = 'Street1';
            lead.City = 'Erd';
            lead.Country = 'IND';
            lead.State = 'TN';
            lead.PostalCode = '638009';
            leadList.add(lead);
        }
        insert leadList;
        return leadList;
    }
    
    //Opportunity Individual
    public static Opportunity createIndOpportunity(Account acc,String Name){
        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name = Name;
        opp.CloseDate = Date.today()+5;
        opp.StageName = 'Prospecting';
        //opp.CreatedDate = System.now()-30;
        insert opp;
        return opp;
    }
    
    //OpportunityList
    public static List<Opportunity> createOpportunity(Account acc,Integer count){
        List<Opportunity> oppList = new List<Opportunity>();
        for(integer i=1;i<=count;i++){
            Opportunity opp = new Opportunity();
            opp.AccountId = acc.Id;
            opp.Name = 'Test Opp '+ i;
            opp.CloseDate = Date.today()+5;
            opp.StageName = 'Prospecting';
            oppList.add(opp);
        }
        insert oppList;
        return oppList;
    }
    
    //OpportunityLineItem Individual
    /*public static OpportunityLineItem createIndOpportunityLineItem(Opportunity opp,String Name){
        OpportunityLineItem opp = new OpportunityLineItem();
        opp. = opp.Id;
        opp.Name = Name;
        opp.CloseDate = Date.today()+5;
        opp.StageName = 'Prospecting';
        //opp.CreatedDate = System.now()-30;
        insert opp;
        return opp;
    }*/
    
    //Product List
    public static List<Product2> createProduct(Integer count){
        List<Product2> proList = new List<Product2>();
        for(integer i=1;i<=count;i++){
            Product2 pro = new Product2();
            pro.Name = 'Test Product '+i;
            pro.IsActive = true;
            proList.add(pro);
        }
        insert proList;
        return proList;
    }

    //PriceBookEntry List
    public static List<PriceBookEntry> createPriceBookEntry(Product2 p,Integer count){
        List<PriceBookEntry> priceList = new List<PriceBookEntry>();
        for(integer i=1;i<=count;i++){
            PriceBookEntry pr = new PriceBookEntry();
            if(Test.isRunningTest())
                pr.Pricebook2Id = Test.getStandardPricebookId();
            else
                pr.Pricebook2Id = [Select id from PriceBook2 where IsStandard = true order by CreatedDate DESC LIMIT 1].Id;
            pr.UnitPrice = 1000;
            pr.Product2Id = p.id;
            pr.IsActive = true;
            priceList.add(pr);
        }
        insert priceList;
        return priceList;
    }
    
    //Asset Individual
    public static Asset createIndAsset(Account acc,String Name){
        Asset ass = new Asset();
        ass.AccountId = acc.Id;
        ass.Name = Name;
        ass.Quantity = 10;
        ass.Price = 5000;
        ass.UsageEndDate = Date.today()+5;
        insert ass;
        return ass;
    }
    
    //User
    public static User createUser(){
        User u = new User();
        Integer randomValue = Integer.valueOf(Math.random()+99);
        u.LastName = 'User Test';
        u.Email = 'testUser@test.com';
        u.Alias = 'UTest';
        u.Username = 'userTest'+randomValue+'@test.com';
        u.LocaleSidKey = 'en_US';
        u.TimeZoneSidKey = 'GMT';
        u.ProfileId = [Select Id from Profile where Name = 'Standard User' LIMIT 1].id;
        u.LanguageLocaleKey = 'en_US';
        u.EmailEncodingKey = 'UTF-8';
        insert u;
        return u;
        
    }

}