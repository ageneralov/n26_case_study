@IsTest
public class TestDataFactory {
    
    public static Contact createContactForSurvey()
    {
        Contact c = new Contact(
            FirstName = 'fname',
            LastName = 'lname',
            email = 'email@email.com',
            language__c = 'en'
        );
        c.survey_date__c = Date.Today() - 1;
        insert c;
        return c;
    }
    
    public static void create50ContactsForSurvey()
    {
        List<Contact> contactsIns = new List<Contact>();
               
        for(Integer i = 1; i <= 50; i++)
        {
            Contact c = new Contact(
                FirstName = 'fname' + string.valueOf(i),
                LastName = 'lname',
                email = 'email' + string.valueOf(i) + '@email.com',
                language__c = 'en'
            );    
            c.survey_date__c = Date.Today() - 1;
            contactsIns.add(c);  
        }
        insert contactsIns;
    }
    
    public static void createSurveyCustomSettings()
    {
        Org_Settings__c os = new Org_Settings__c();
        os.ContactSurveySupportedLanguages__c = 'en;de';
        insert os;
    }
    
    public static EmailTemplate createSurveyEmailTemplate()
    {
        for(EmailTemplate existing : [select id, developerName, TemplateType from EmailTemplate where developerName = 'SurveyTemplate_en'])
        {
            return existing;
        }
        
        EmailTemplate e = new EmailTemplate (
            developerName = 'SurveyTemplate_en', 
            FolderId = UserInfo.getOrganizationId(), 
            TemplateType = 'Text',
            Body = 'Hey {!Contact.FirstName}, Please fill out our survey: http://n26.com/survey/{!Contact.Id}',
            Name = 'Survey Template EN'
        ); 
        
        insert e;
        return e;
    }
    
    public static Product2 createProduct()
    {
        Product2 p = new Product2(
            Name = 'Standard'
        );
        insert p;
        return p;
    }
    
    public static Country__c createCountry()
    {
        Country__c c = new Country__c(
            Name = 'Germany',
            Country_Code__c = 'de'
        );
        insert c;
        return c;
    }
    
    public static Contact createContact(String ProductId, String CountryId)
    {
        Contact c = new Contact(
            FirstName = 'FirstName',
            LastName = 'LastName',
            Home_Country__c = CountryId,
            Product__c = ProductId
        );
        insert c;
        return c;
    }
    
    public static Case createCase(String ContactId)
    {
        Case c = new Case(
            Subject = 'TestCase',
            ContactId = ContactId
        );
        insert c;
        return c;
    }
    
    public static Product_Country_Price__c createProductPricing(String ProductId, String CountryId)
    {
    	Product_Country_Price__c pcp = new Product_Country_Price__c(
            Product__c = ProductId, 
            Country__c = CountryId, 
            Cost_per_Calendar_Month__c = 0, 
            Card_Replacement_Cost__c = 0.017, 
            ATM_Fee_in_other_currencies__c = 6
		);
    	insert pcp;
        return pcp;
    }
}