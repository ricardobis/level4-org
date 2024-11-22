@isTest
global class CalloutMockGenerator implements HttpCalloutMock {
    private String body; 
    private Blob bodyBlob; 
    private String status; 
    private Integer statusCode; 
    private Integer statusCodeToken;
    private String bodyToken;
    private String namedCredentialToken; 

    global CalloutMockGenerator(String body, Integer statusCode, String status) {
        this.body = body;
        this.bodyBlob = null;
        this.status = status;
        this.statusCode = statusCode;
    }
    
    global CalloutMockGenerator(Blob bodyBlob, Integer statusCode, String status) {
        this.body = null;
        this.bodyBlob = bodyBlob;
        this.status = status;
        this.statusCode = statusCode;
    }

    // Constructor for creating a CalloutMockGenerator object with a response body, status code, and status string for token-based calls.
    global CalloutMockGenerator(String body, Integer statusCode, String status, String namedCredentialToken) {
        this.body = body;
        this.status = status;
        this.statusCode = statusCode;
        this.bodyToken = '{"access_token": "MockedAccessToken", "expires_in": 3600}';
        this.statusCodeToken = 200;
        this.namedCredentialToken = namedCredentialToken;   
    }
    
    // Method respond for implementing the HttpCalloutMock interface
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        
        // Checks if the call contains a named credential token
        if (this.namedCredentialToken != null && this.namedCredentialToken != '' && request.getEndpoint().contains(this.namedCredentialToken)) {
            response.setStatusCode(this.statusCodeToken);
            response.setBody(this.bodyToken);   
        } else {
            // If it doesn't contain a named credential token, checks if there's a response body as Blob
            if (this.bodyBlob != null) {
                response.setBodyAsBlob(this.bodyBlob);
            } else {
                // If there's no response body as Blob, uses the response body as String
                response.setBody(this.body);
            } 
            response.setStatusCode(this.statusCode);
        }       
        
        response.setStatus(this.status);
                
        return response;
    }

}