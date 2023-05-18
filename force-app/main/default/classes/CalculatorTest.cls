@isTest
public class CalculatorTest {

    @isTest
    public static void testAdd(){
        Test.startTest();
        Decimal num1 = 2.1;
        Decimal num2 = 3.5;
        Decimal result = Calculator.addition(num1, num2);
        System.debug('---Result---'+result);
        Test.stopTest();
    }
    
    @isTest
    public static void testAddNull(){
        Test.startTest();
        Decimal num1;
        Decimal num2 = 3.5;
        Decimal result = Calculator.addition(num1, num2);
        System.debug('---Result---'+result);
        Test.stopTest();
    }
    
    @isTest
    public static void testSub(){
        Test.startTest();
        Decimal num1 = 2.1;
        Decimal num2 = 3.5;
        Decimal result = Calculator.subtraction(num1, num2);
        System.debug('---Result---'+result);
        Test.stopTest();
    }
    
    @isTest
    public static void testSubNull(){
        Test.startTest();
        Decimal num1;
        Decimal num2 = 3.5;
        Decimal result = Calculator.subtraction(num1, num2);
        System.debug('---Result---'+result);
        Test.stopTest();
    }
    
    @isTest
    public static void testMul(){
        Test.startTest();
        Decimal num1 = 2.1;
        Decimal num2 = 3.5;
        Decimal result = Calculator.multiplication(num1, num2);
        System.debug('---Result---'+result);
        Test.stopTest();
    }
    
    @isTest
    public static void testMulNull(){
        Test.startTest();
        Decimal num1;
        Decimal num2 = 3.5;
        Decimal result = Calculator.multiplication(num1, num2);
        System.debug('---Result---'+result);
        Test.stopTest();
    }
    
    @isTest
    public static void testDiv(){
        Test.startTest();
        Decimal num1 = 2.1;
        Decimal num2 = 3.5;
        Decimal result = Calculator.division(num1, num2);
        System.debug('---Result---'+result);
        Test.stopTest();
    }
    
    @isTest
    public static void testDivNull(){
        Test.startTest();
        Decimal num1;
        Decimal num2 = 3.5;
        Decimal result = Calculator.division(num1, num2);
        System.debug('---Result---'+result);
        Test.stopTest();
    }
}