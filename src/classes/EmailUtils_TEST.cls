@IsTest
public class EmailUtils_TEST {

    private static testmethod void test_sendEmailFromTemplate() 
    {
    	EmailTemplate et = TestDataFactory.createSurveyEmailTemplate();
        Contact c = TestDataFactory.createContactForSurvey();
        
        Test.startTest();

        	Messaging.SendEmailResult [] res = EmailUtils.sendEmailFromTemplate(c.Id, et.Id, 'Sender Name');
        
        Test.stopTest();
        
        System.assertEquals(true, res[0].isSuccess());
    }
}