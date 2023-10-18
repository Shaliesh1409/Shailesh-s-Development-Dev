// public class DropBoxService {
    
//     public class Header {
//         public String path { get; set; }
//         public String mode { get; set; }
//         public Boolean autorename { get; set; }
//         public Boolean mute { get; set; }
//         public Boolean strict_conflict { get; set; }
//     }
    
//     private static String fileLocation(String file) {
//         return '/fileuploader-integration/' + file;  
//     }
    
//     private static String createHeaderArgs(String file) {
//         Header header = new Header();
//         header.path = fileLocation(file);
//         header.mode = 'add';
//         header.autorename = true;
//         header.mute = false;
//         header.strict_conflict = false;
//         return JSON.serialize(header);
//     }
    
//     public static String upload(ContentVersion content) {
//         HttpRequest req = new HttpRequest();
//         req.setHeader('Content-Type', 'application/octet-stream');
//         req.setMethod('POST');
//         req.setEndpoint('callout:DropBox/2/files/upload');   
//         req.setBodyAsBlob(content.VersionData);
//         String fileName = content.Title + '.' + content.FileExtension;
//         req.setHeader('DropBox-API-Arg', createHeaderArgs(fileName));
//         req.setHeader('Authorization', 'Bearer ' + Label.DropBoxKey);   
//         req.setTimeout(120000);
    
//         Http http = new Http();
//         HTTPResponse res = http.send(req);
//         System.debug('Response: ' + res.getBody());
    
//         return fileLocation(fileName);
//     }
// }


// public class DropBoxService {
//     public class Header {
//         public String path { get; set; }
//         public String mode { get; set; }
//         public Boolean autorename { get; set; }
//         public Boolean mute { get; set; }
//         public Boolean strict_conflict { get; set; }
//     }

//     // Customize the file location based on your requirements
//     private static String fileLocation(String file, String folderPath) {
//         return folderPath + '/fileuploader-integration/' + file;
//     }

//     // Customize the header arguments as needed
//     private static String createHeaderArgs(String file, String folderPath) {
//         Header header = new Header();
//         header.path = fileLocation(file, folderPath);
//         header.mode = 'add';
//         header.autorename = true;
//         header.mute = false;
//         header.strict_conflict = false;
//         return JSON.serialize(header);
//     }

//     public static String Upload(ContentVersion content) {
//         HttpRequest req = new HttpRequest();
//         req.setHeader('Content-Type', 'application/octet-stream');
//         req.setMethod('POST');
//         req.setEndpoint('callout:DropBox/2/files/upload');
//         req.setBodyAsBlob(content.VersionData);
//         String fileName = content.Title + '.' + content.FileExtension;
//         req.setHeader('DropBox-API-Arg',createHeaderArgs(content.Title+'.'+content.FileExtension));
//         req.setHeader('Authorization', 'Bearer ' + Label.DropBoxKey);
//         req.setTimeout(120000);
//         Http http = new Http();
//         HTTPResponse res = http.send(req);

//         if (res.getStatusCode() == 200) {
//             System.debug('File uploaded successfully. Response: ' + res.getBody());
//             return fileLocation(fileName);
//         } else {
//             System.debug('Error uploading file. Status Code: ' + res.getStatusCode());
//             return null;
//         }
//     }
// }



public class DropBoxService {
    
    public class Header
 {
     public string path{get;set;}
     public string mode{get;set;}
     public boolean autorename{get;set;}
     public boolean mute{get;set;}
     public boolean strict_conflict{get;set;}
 }
 private static string fileLocation(string file)
 {
     return '/folderforintegration/'+file;  // Change Folder based on your requirement
 }
 private static string createHeaderArgs(string file)
 {
     Header header=new Header();
     header.path=fileLocation(file);
     header.mode='add';
     header.autorename=true;
     header.mute=false;
     header.strict_conflict=false;
     return JSON.serialize(header);
 }
     
 public static string Upload(ContentVersion content)
 {
     HttpRequest req = new HttpRequest();
     req.setHeader('Content-Type','application/octet-stream');
     req.setMethod('POST');
     req.setEndpoint('callout:DropBox/2/files/upload');
     req.setBodyAsBlob(content.VersionData);
     string fileName=content.Title+'.'+content.FileExtension;
     req.setHeader('DropBox-API-Arg', createHeaderArgs(content.Title+'.'+content.FileExtension));
     req.setHeader('Authorization','Bearer '+Label.DropBoxKey);
     req.setTimeout(120000);
     Http http = new Http();
     HTTPResponse res = http.send(req);
     system.debug('Response:'+res.getBody());
     return fileLocation(fileName);


}
 
}
