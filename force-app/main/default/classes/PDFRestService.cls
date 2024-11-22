public class PDFRestService {

    
    public static String extractText(ContentVersion file) {
        String file_name = file.Title + '.' + file.FileExtension; 
 
        String boundary = '--pdfRest-boundary-string';
      
        //String param_pages1 = '--' + boundary + '\r\nContent-Disposition: form-data; name="file"\r\n\r\n';   
        
        String file_header = '\r\n--' + boundary + 
        '\r\nContent-Disposition: form-data; name="file"; filename="' + 
        file_name + '"\r\nContent-Type: application/octet-stream\r\n\r\n';
        
        Blob file_body = file.VersionData;
        
        String footer = '\r\n--'+boundary+'--';
    
        String combinedDataAsHex =  
          EncodingUtil.convertToHex(Blob.valueOf(file_header)) + 
          EncodingUtil.convertToHex(file_body) + 
          EncodingUtil.convertToHex(Blob.valueOf(footer));
        
        Blob bodyBlob = EncodingUtil.convertFromHex(combinedDataAsHex);
            
        HttpRequest req = new HttpRequest();
        req.setHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
        req.setHeader('Accept', 'application/json');
        req.setMethod('POST');
        req.setEndpoint('callout:PDFRest_Extract');
        req.setBodyAsBlob(bodyBlob);
        req.setTimeout(120000);
        Http http = new Http();
        HTTPResponse res = http.send(req);
		
        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        String fullText = (String)m.get('fullText');
        
        return fullText;
    }
}