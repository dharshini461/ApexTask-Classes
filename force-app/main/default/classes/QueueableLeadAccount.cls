public class QueueableLeadAccount implements Queueable{
	
    public Lead lead;
    public QueueableLeadAccount(Lead lead){
        this.lead = lead;
    }
    
    public void execute(QueueableContext qc){
            Account acc = new Account();
            acc.Name = lead.Company;
            acc.Industry = lead.Industry;
            acc.BillingStreet = lead.Street;
            acc.BillingCity = lead.City;
            acc.BillingState = lead.State;
            acc.BillingCountry = lead.Country;
            acc.BillingPostalCode = lead.PostalCode;
            insert acc;
        
    }
}