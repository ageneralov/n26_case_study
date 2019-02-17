public class EmailUtils {
 
    public static Messaging.SendEmailResult [] sendEmailFromTemplate(string contactId, string templateId, string senderName)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        mail.setTargetObjectId(contactId); 
        mail.setSenderDisplayName(senderName);
        mail.setUseSignature(false); 
        mail.setBccSender(false); 
        mail.setSaveAsActivity(false); 
        mail.setTemplateId(templateId); 
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        return r;
    }
}