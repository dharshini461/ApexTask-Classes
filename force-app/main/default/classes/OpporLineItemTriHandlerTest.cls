@isTest(seeAllData=false)
public class OpporLineItemTriHandlerTest {
    
    @isTest
    static void assetToRelatedAcc(){
        System.assert([Select Id from Asset order by CreatedDate DESC LIMIT 5].size()>0);
    }

}