@IsTest
public class ContactSurveyEmailBatch_TEST {

    static testmethod void test_surveyEmailBatch() {        
        
        TestDataFactory.createSurveyCustomSettings();
        TestDataFactory.createSurveyEmailTemplate();
        TestDataFactory.createContactForSurvey();
        
        Test.startTest();
        ContactSurveyEmailBatch c_surv_batch = new ContactSurveyEmailBatch();
        Id batchId = Database.executeBatch(c_surv_batch);
        Test.stopTest();

        System.assertEquals(1, [select count() from contact where survey_date__c = NULL]);
    }
    
    static testmethod void test_surveyEmail50Batch() {        
        
        TestDataFactory.createSurveyCustomSettings();
        TestDataFactory.createSurveyEmailTemplate();
        TestDataFactory.create50ContactsForSurvey();
        
        Test.startTest();
        ContactSurveyEmailBatch c_surv_batch = new ContactSurveyEmailBatch();
        Id batchId = Database.executeBatch(c_surv_batch);
        Test.stopTest();

        System.assertEquals(50, [select count() from contact where survey_date__c = NULL]);
    }
    
    
}