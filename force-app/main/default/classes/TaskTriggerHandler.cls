public with sharing class TaskTriggerHandler extends TriggerHandler {
    
    public override void beforeDelete(){
        TaskUtility.deletetaskbyAdminHandler(Trigger.new);
    }
}