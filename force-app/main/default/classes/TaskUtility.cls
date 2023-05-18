public with sharing class TaskUtility {
    
    public static void deletetaskbyAdminHandler(List<Task> taskList){
        Id pid = Userinfo.getProfileId();
        Profile pname = [Select Name from Profile where id=:pid];
        for(Task t : taskList){
            if(pname.Name != 'System Administrator'){
                t.addError('No Access for Deletion');
            }
        }
    }

}