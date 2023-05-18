public class Calculator {
    //public class MyException extends Exception {}
    static Integer scale = 3;
    public static Decimal addition(Decimal num1,Decimal num2){
        Decimal result;
        /*try{
            if(num1 != null && num2 != null){
                //throw new MyException('Null value not accepted');
                result = num1 + num2; 
            }
            return result.setScale(scale);
            
        }catch(Exception e){
            //System.debug('---Exception Message---'+e.getMessage());
            return result.setScale(scale);
        }*/
        if(num1 == null || num2 == null){
            result = 0; 
        }
        else{
            result = num1 + num2;
        }
        return result.setScale(scale);
    }
    
    public static Decimal subtraction(Decimal num1,Decimal num2){
        Decimal result;
        if(num1 == null || num2 == null){
            result = 0; 
        }
        else{
            result = (num1 - num2).abs();
        }
        return result.setScale(scale);
    }
    
    public static Decimal multiplication(Decimal num1,Decimal num2){
        Decimal result;
        if(num1 == null || num2 == null){
            result = 0; 
        }
        else{
            result = num1 * num2;
        }
        return result.setScale(scale);
    }
    
    public static Decimal division(Decimal num1,Decimal num2){
        Decimal result;
        if(num1 == null || num2 == null){
            result = 0; 
        }
        else{
            result = num1 / num2;
        }
        return result.setScale(scale);
    }

}