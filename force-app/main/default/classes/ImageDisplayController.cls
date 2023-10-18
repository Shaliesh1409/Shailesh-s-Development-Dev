public with sharing class ImageDisplayController {

    @AuraEnabled
    public static String fetchImage(String imageUrl) {
        String imageSrc = '';
        
        // Validate the URL (check for empty URL)
        if (String.isBlank(imageUrl)) {
            return imageSrc; // Return an empty string for invalid URLs
        }
        
        // Fetch the image data (assuming it's an HTTP request)
        try {
            HttpRequest request = new HttpRequest();
            request.setEndpoint(imageUrl);
            request.setMethod('GET');
            
            HttpResponse response = new Http().send(request);
            
            if (response.getStatusCode() == 200) {
                // Successful response, set the image source
                imageSrc = imageUrl;
            } else {
                // Handle non-200 response status codes as needed
                System.debug('Image fetch failed with status code: ' + response.getStatusCode());
            }
        } catch (Exception e) {
            // Handle any exceptions that may occur during the HTTP request
            System.debug('Exception while fetching image: ' + e.getMessage());
        }
        
        return imageSrc;
    }
}