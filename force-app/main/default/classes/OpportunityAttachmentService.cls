public class OpportunityAttachmentService {

    public String opportunityIds; 

    public OpportunityAttachmentService(ApexPages.StandardController controller){
        opportunityIds =  System.currentPageReference().getParameters().get( 'id' );
        System.debug(opportunityIds + 'Opp Id');
    }
    private static final String UNSPLASH_API_KEY = '10OOwuwbqJNgRj_BpRqDw7fvtOlz0hRkKHJgqF3RfGY';

    @future(callout=true)
    public static void attachRandomImageToOpportunity(String opportunityId) {              //Id opportunityId
        try {
            // Id opportunityId = '0065j00001PLy0LAAT' ;
           

            System.debug('opportunityId-->' + opportunityId);
            String endpoint = 'https://api.unsplash.com/photos/random?client_id=' + UNSPLASH_API_KEY;
    
            HttpRequest request = new HttpRequest();
            request.setEndpoint(endpoint);
            request.setMethod('GET');
    
            HttpResponse response = new Http().send(request);
            System.debug('Endpoint: ' + endpoint);
            System.debug('Response Body: ' + response.getBody());
            System.debug(response.getStatusCode());
    
            if (response.getStatusCode() == 200) 
            {
                // Parse the JSON response to extract the image URL
                Map<String, Object> jsonResponse = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                System.debug('jsonResponse-==>'+jsonResponse);
                System.debug('jsonResponse-==>'+jsonResponse.get('urls'));
    
                Map<String, Object> imageUrl = (Map<String, Object>)jsonResponse.get('urls');
                // imageUrl = imageUrl.get('regular');
                //System.debug('jsonResponse-==>'+imageUrl.get('regular'));
                String url = (String) imageUrl.get('regular');
                 System.debug('url--> ' +url);
    
                //Create an Attachment record and associate it with the Opportunity
                
                HttpRequest request2 = new HttpRequest();
                request2.setEndpoint(url);
                request2.setMethod('GET');
        
                HttpResponse response2 = new Http().send(request2);
                System.debug('Endpoint 2 : ' + url);
                System.debug('Response Body 2 : ' + response2.getBody());
                System.debug(response2.getStatusCode());


                ContentVersion contentVersion = new ContentVersion();
                contentVersion.VersionData = response2.getBodyAsBlob();
                contentVersion.Title = 'UnsplashImage.jpg';
                contentVersion.PathOnClient = 'UnsplashImage.jpg';
                contentVersion.FirstPublishLocationId = opportunityId;

                insert contentVersion;

                //  Attachment attachment = new Attachment();
                //  attachment.ParentId = opportunityId;
                //  attachment.Name = 'UnsplashImage.jpg';
                //  attachment.Body = response2.getBodyAsBlob();
                //  attachment.ContentType = 'image/jpeg';
                //  insert attachment;
                 System.debug('image added successfully');
            } else {
                System.debug('Error: Unable to fetch an image from Unsplash API. Status code: ' + response.getStatusCode());
            }
        } catch (Exception e) {
            System.debug(e);
        }
    }

    public void passid(){
        System.debug('passID');
        System.debug(opportunityIds);
        OpportunityAttachmentService.attachRandomImageToOpportunity(opportunityIds);
        // return null;
    }
}