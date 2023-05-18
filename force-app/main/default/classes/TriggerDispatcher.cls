public class TriggerDispatcher {

    public static void run(LTriggerHandler handler, string triggerName){
        switch on Trigger.operationType {
            when AFTER_INSERT {
                //Invoke after insert trigger handler
                handler.afterInsert(trigger.new);
            }
        }
    }
}