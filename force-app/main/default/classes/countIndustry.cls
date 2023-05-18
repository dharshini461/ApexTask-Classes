public class countIndustry {
    
    public static void eachIndustryCount(){
        List<AggregateResult> industryValue = [SELECT Industry,count(Id) countIndustry FROM Account where Industry<>null group by Industry];
        System.debug('---List of Industries---');
        for(AggregateResult agres : industryValue){
            System.debug('---Industry : '+agres.get('Industry')+'--->Count : '+agres.get('countIndustry'));
        }
      
    }

}