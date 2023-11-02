public with sharing class CommunityAuthController {
    public CommunityAuthController() {

    }

    @AuraEnabled
    public static string doLogin(String username, String password){
        try {
            
            String startUrl = System.Label.Community_Url;
            ApexPages.PageReference pageRef = Site.login(username, password, startUrl);

            if(pageRef != null) {
                return pageRef.getUrl();
            }

            // throw new CalloutException();

            return null;


        } catch (Exception e) {
            system.debug('e.getMessagelogin+   '+e.getMessage());
            throw new AuraHandledException(e.getMessage());

            // return null;
        }
    }


    @AuraEnabled
    public static boolean isEmailExist(String username){
        try {
            
            List<User> userList = new List<User>();
            userList = [Select Id, Name From User Where Username = :username];

            // throw new CalloutException();

            return !userList.isEmpty();


        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());

            // return null;
        }
    }

    // @AuraEnabled
    // public static string registerUser(String firstName, String lastName, String username, String email, String communityNickname, String password){
    //     try {


           
    //         Set<String> communityNicknameSet = new Set<String>();

    //         for(User usr : [Select Id, CommunityNickname From User Where CommunityNickname != null]){

    //             communityNicknameSet.add(usr.CommunityNickname);
    //         }

    //         String uniqueCommunityNickName;
    //         System.debug('method called');

    //         if(communityNicknameSet.isEmpty()){

    //             if(communityNickname.length() > 4){
                    
    //                 uniqueCommunityNickName = communityNickname.substring(0, 4) + String.valueOf( Integer.valueOf(Math.random() * 10000) );
                
    //             } else {

    //                 uniqueCommunityNickName = communityNickname + String.valueOf( Integer.valueOf(Math.random() * 10000) );
    //             }
            
    //         } else {

    //             for(Integer i=1; i <= 9999 ; i++){

    //                 if(communityNickname.length() > 4){
                        
    //                     uniqueCommunityNickName = communityNickname.substring(0, 4) + String.valueOf( Integer.valueOf(Math.random() * 10000) );
                    
    //                 } else {

    //                     uniqueCommunityNickName = communityNickname + String.valueOf( Integer.valueOf(Math.random() * 10000) );
    //                 }

    //                 if(!communityNicknameSet.contains(uniqueCommunityNickName)){

    //                     break;
    //                 }
    //             }
    //         }
            
    //         User u = new User();
    //         u.firstName = firstName;
    //         u.lastName = lastName;
    //         u.Username = username;
    //         u.Email = email;
    //         u.CommunityNickname = uniqueCommunityNickName;        

    //         String accountId;

    //         Account portalAccount = new Account();
    //         portalAccount.Name = firstName + ' ' + lastName;
    //         insert portalAccount;

    //         portalAccount.IsPartner = true;
    //         update portalAccount;

    //         accountId = portalAccount.Id;
            


    //         String userId = Site.createPortalUser(u, accountId, password);

    //         if (userId != null) {
                
    //             String emailResult = sendWelcomeMail(u, userId);
                
    //             if (password != null && password.length() > 1) {
    //                 ApexPages.PageReference pageRef = Site.login(username, password, null);
    //                 if(pageRef != null) 
    //                 {
    //                     return pageRef.getUrl();
    //                 }
    //             }
    //             else {
    //                 ApexPages.PageReference page = System.Page.SiteRegisterConfirm;
    //                 page.setRedirect(true);
    //                 return page.getUrl();
    //             }
    //         }

    //         // throw new CalloutException();

    //         return null;


    //     } catch (Exception e) {
    //         system.debug('e.getMessage+   '+e.getMessage());
            
    //         if(!Test.isRunningTest()) throw new AuraHandledException(e.getMessage());

    //         return null;
            
    //     }
    // }


    @AuraEnabled
    public static String registerUser(String firstName, String lastName, String username, String email, String password,String Role,String subject ,String department ) {
        try {

        // UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        // Profile profile1 = [Select Id from Profile where name = 'System Administrator'];
        // User portalAccountOwner1 = new User(
        //  UserRoleId = portalRole.Id,
        //  ProfileId = profile1.Id,
        //  Username = 'dotnetcodex@gmail.com' + System.now().millisecond() ,
        //  Alias = 'sfdc',
        //  Email='dotnetcodex@gmail.com',
        //  EmailEncodingKey='UTF-8',
        //  Firstname='Dhanik',
        //  Lastname='Sahni',
        //  LanguageLocaleKey='en_US',
        //  LocaleSidKey='en_US',
        //  TimeZoneSidKey='America/Chicago'
        // );
        // insert(portalAccountOwner1);

              Account newAccount = new Account(
                Name = lastName
                // OwnerId = portalAccountOwner1.id
            );
            insert newAccount;
            


               Contact newContact = new Contact(
                FirstName = firstName,
                LastName = lastName,
                Email = email,
                AccountId = newAccount.Id,
                Role__c = Role
            );
             insert newContact;

            Profile portalProfile = [SELECT Id FROM Profile WHERE Name='Customer Community User' Limit 1];
            User newUser = new User(
                FirstName = firstName,
                LastName = lastName,
                Username = username,
                Email = email,
                ProfileId = portalProfile.Id,    //'00e5j000004VqdAAAS',                               //  
                // UserRoleId = '00E5j000000Wd4xEAC', 
                CommunityNickname = username, 
                ContactId = newContact.Id,
                Alias =  firstName ,
                EmailEncodingKey = 'UTF-8',
                TimeZoneSidKey = 'America/Los_Angeles',
                LocaleSidKey = 'en_US',
                LanguageLocaleKey = 'en_US'
            );
            
            insert newUser;

            System.setPassword(newUser.Id, password);
     
            // Optionally, send a welcome email to the user
            sendWelcomeMail(newUser,newUser.Id);
            return 'success';

        } catch (Exception e) {
           
            System.debug(e.getMessage() + e.getStackTraceString() + e.getLineNumber());
            return 'error: ' + e.getMessage();
        }
    }


    @AuraEnabled
    public static string sendWelcomeMail(User usr, String userId){
        try {

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            List<EmailTemplate> welcomeTemplate = new List<EmailTemplate>([Select Id from EmailTemplate where name = 'welcome-to_community']);
                     
            mail.setSenderDisplayName(System.Label.Community_Email_Sender);
            mail.setTargetObjectId(userId);
            mail.setTemplateId(welcomeTemplate[0].Id);
            mail.setSaveAsActivity(false);

            Messaging.sendEmail( new List<Messaging.SingleEmailMessage>{mail} );

            return 'success';

        } catch (Exception e) {            
            throw new AuraHandledException(e.getMessage());
        }
    }

}