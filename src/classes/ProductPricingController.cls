public class ProductPricingController {

    @AuraEnabled
 	public static Product_Country_Price__c getPricing(String caseId) {
 		
    for( Case c : [Select Id, ContactId, Contact.Home_Country__c, Contact.Product__c from Case where id = :caseId] )
    {
        if(c.Contact.Home_Country__c != NULL && c.Contact.Product__c != NULL)
        {
            for(Product_Country_Price__c pcp : [select Id, Product__c, Country__c, Cost_per_Calendar_Month__c, 
                                                		Card_Replacement_Cost__c, ATM_Fee_in_other_currencies__c
                                                from Product_Country_Price__c 
                                                where Product__c = :c.Contact.Product__c AND Country__c = :c.Contact.Home_Country__c])
            {
                return pcp;
            }
        }
    }
    
 	return NULL;
 }
    
    
}