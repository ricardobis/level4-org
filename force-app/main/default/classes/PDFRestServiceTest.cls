@IsTest
public class PDFRestServiceTest {

    @IsTest
    static void testExtractText() {
        // Create a mock ContentVersion file
        ContentVersion testFile = new ContentVersion();
        testFile.Title = 'TestPDF';
        testFile.VersionData = Blob.valueOf('Dummy PDF content');
        
        // Mock the HTTPResponse for the HTTP callout
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setHeader('Content-Type', 'application/json');
        mockResponse.setBody('{"fullText": "Extracted text from PDF"}');
        mockResponse.setStatusCode(200);
        
        // Set up the HttpCalloutMock
        Test.setMock(HttpCalloutMock.class, new PDFRestServiceHttpMock(mockResponse));
        
        // Call the method and capture the result
        String extractedText = PDFRestService.extractText(testFile);
        
        // Verify the result
        System.assertEquals('Extracted text from PDF', extractedText, 'The extracted text does not match the expected value.');
    }

    // Mock class for the HTTP callout
    private class PDFRestServiceHttpMock implements HttpCalloutMock {
        private HttpResponse mockResponse;
        
        public PDFRestServiceHttpMock(HttpResponse mockResponse) {
            this.mockResponse = mockResponse;
        }
        
        public HTTPResponse respond(HTTPRequest req) {
            // Verify the request details
            System.assertEquals('POST', req.getMethod(), 'HTTP method is incorrect.');
            System.assertEquals('callout:PDFRest_Extract', req.getEndpoint(), 'Endpoint URL is incorrect.');
            System.assert(req.getBodyAsBlob() != null, 'Request body should not be null.');
            System.assert(req.getHeader('Content-Type').startsWith('multipart/form-data'), 'Content-Type header is incorrect.');
            
            return mockResponse;
        }
    }
}