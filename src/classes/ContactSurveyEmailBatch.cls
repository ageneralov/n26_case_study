public class ContactSurveyEmailBatch implements 
    Database.Batchable<sObject>, Database.Stateful {
    
    //Email Template DeveloperName format is SurveyTemplate_[LanguageCode]
    public static final String SURVEY_EMAIL_NAME = 'SurveyTemplate_';
        
    public static final String SURVEY_EMAIL_DEFAULT_LANGUAGE = 'en'; 
        
    //value from Custom Settings in format "en;de"
    public static final Set<string> SURVEY_EMAIL_SUPPORTED_LANGUAGES 
        = new Set<String>(String.valueOf(Org_Settings__c.getInstance().ContactSurveySupportedLanguages__c).split(';'));
       
    public static final Integer APEX_DAYLY_EMAIL_LIMIT = 1000;    
          
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, survey_date__c, language__c ' +
            ' FROM Contact ' + 
            ' Where survey_date__c < TODAY ' +
            ' Limit ' + string.valueOf(APEX_DAYLY_EMAIL_LIMIT)
        );
    }
        
    public void execute(Database.BatchableContext bc, List<Contact> scope){
		List<Contact> contactsToUpdate = new List<Contact>();
	       for (Contact c : scope){
	           if (sendSurveyEmailToContact(c.Id, c.language__c) == true)
               {
                   	c.survey_date__c = NULL;
	           		contactsToUpdate.add(c);
               }
	       }
	       update contactsToUpdate; 
    }
        
    private boolean sendSurveyEmailToContact(string contactId, string languageCode)
    {
        if (languageCode == NULL || !SURVEY_EMAIL_SUPPORTED_LANGUAGES.contains(languageCode) )
        {
            languageCode = SURVEY_EMAIL_DEFAULT_LANGUAGE;
        }
        string emailTemplateName = SURVEY_EMAIL_NAME + languageCode;
        for (EmailTemplate et : [Select id from EmailTemplate where DeveloperName = :emailTemplateName limit 1])
        {
            return EmailUtils.sendEmailFromTemplate(contactId, et.Id, 'Salesforce Support')[0].isSuccess();
        }
        return false;
    }    
        
    public void finish(Database.BatchableContext bc){

    }    
}