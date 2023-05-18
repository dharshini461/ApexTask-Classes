public class LeadTriggerHandler implements LTriggerHandler {
    
    public static void afterInsert(List<Lead> newlead){
        if(checkRecursive.runOneTime()){
            List<Lead> leadList = new List<Lead>();
            leadList = newlead.deepClone();
            insert leadList;
        }
    }

}