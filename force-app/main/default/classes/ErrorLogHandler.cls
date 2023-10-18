public class ErrorLogHandler {
    public static void createErrorLog(String className, String exceptionMessage, Integer lineNumber, String methodName, String exceptionType, String moreDetails) {
        try {
            Error_Log__c errorLog = new Error_Log__c(
                Class_Name__c = className,
                Exception_Message__c = exceptionMessage,
                Line_Number__c = lineNumber,
                Method_Name__c = methodName,
                Exception_Type__c = exceptionType,
                More_Details__c = moreDetails
            );
            insert errorLog;
        } catch (Exception e) {
            // Handle any exceptions that occur during the creation and insertion of the Error Log record.
            System.debug('Error creating Error Log: ' + e.getMessage());
        }
    }
}