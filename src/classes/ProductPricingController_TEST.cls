@IsTest
public class ProductPricingController_TEST {

    private static testmethod void test_getPricing() 
    {
    	Product2 p = TestDataFactory.createProduct();
        Country__c c = TestDataFactory.createCountry();
        Contact con = TestDataFactory.createContact(p.Id, c.Id);
        Case cs = TestDataFactory.createCase(con.Id);
        Product_Country_Price__c pcp = TestDataFactory.createProductPricing(p.Id, c.Id);
        
        Test.startTest();

        	Product_Country_Price__c pcp2 = ProductPricingController.getPricing(cs.Id);
        
        Test.stopTest();
        
        System.assertEquals(pcp.Id, pcp2.Id);
    }
    
}