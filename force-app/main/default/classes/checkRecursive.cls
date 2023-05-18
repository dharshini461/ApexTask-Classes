public class checkRecursive {
    
    static boolean flag = true;
    public static boolean runOneTime(){
        if(flag){
            flag = false;
            return true;
        }
        else{
            return flag;
        }
    }

}