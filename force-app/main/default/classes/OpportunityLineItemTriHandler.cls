public with sharing class OpportunityLineItemTriHandler {

    public static void assetToRelatedAcc(List<OpportunityLineItem> otl){
        List<Asset> asslist = new List<Asset>();
        for(OpportunityLineItem oppProd : otl){
            Opportunity opp = [Select AccountId,Account.Name from Opportunity where Id =: oppProd.OpportunityId LIMIT 1];
            if(opp.AccountId != null){
                Asset ass = new Asset();
                ass.Name = opp.Account.Name+' OppLineItem';
                ass.AccountId = opp.AccountId;
                ass.Product2Id = oppProd.Product2Id;
                ass.Quantity = oppProd.Quantity;
                ass.Price = oppProd.UnitPrice;
                ass.UsageEndDate = Date.today();
                asslist.add(ass);
            }
        }
        
        if(asslist.size()>0){
            insert asslist;
        }
    }
}