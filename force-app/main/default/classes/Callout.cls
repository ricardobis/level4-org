public class Callout {
    // public static HttpResponse executeHttpGet(String endpoint, Map<String, String> headers){
    //     return Callout.executeHttpGet(endpoint, null, headers);
    // }

    // public static HttpResponse executeHttpGet(String endpoint, Map<String, String> params, Map<String, String> headers){
    //     return Callout.executeHttpRequest('GET', endpoint, params, headers, null);
    // }

    // public static HttpResponse executeHttpPost(String endpoint, Map<String, String> headers, String body){
    //     return Callout.executeHttpPost(endpoint, null, headers, body);
    // }

    // public static HttpResponse executeHttpPost(String endpoint, Map<String, String> params, Map<String, String> headers, String body){
    //     return Callout.executeHttpRequest('POST', endpoint, params, headers, body);
    // }

    // public static HttpResponse executeHttpPut(String endpoint, Map<String, String> params, Map<String, String> headers, String body){
    //     return Callout.executeHttpRequest('PUT', endpoint, params, headers, body);
    // }
    
    // public static HttpResponse executeHttpRequest(String endpoint, String method, Map<String, String> headers, String body){
    //     return Callout.executeHttpRequest(method, endpoint, null, headers, body);
    // }

    // public static HttpResponse executeHttpRequest(String method, String endpoint, Map<String, String> params, Map<String, String> headers, String body){
    //     HttpRequest request = new HttpRequest();                
    //     request.setMethod(method);
    //     request.setTimeout(30000);
        
    //     Callout.setEndpoint(request, endpoint, params);
    //     Callout.setHeaders(request, headers);
    //     Callout.setBody(request, body);                
            
    //     Http http = new Http();        
    //     HttpResponse response = http.send(request);
    //     return response;
    // }

    // public static void  setEndpoint(HttpRequest request, String endpoint, Map<String, String> params) {
    //     if (params != null && !params.isEmpty()) {
    //         endpoint = endpoint + Callout.getParams(params);
    //     }

    //     request.setEndpoint(endpoint);
    // }

    // public static void  setBody(HttpRequest request, String body) {
    //     if(String.isNotBlank(body)){
    //         request.setBody(body);
    //     }
    // }

    // public static void  setHeaders(HttpRequest request, Map<String, String> headers) {
    //     if (headers != null && !headers.isEmpty()) {
    //         for (String key : headers.keySet()) {
    //             request.setHeader(key, headers.get(key));
    //         }    
    //     }
    // }

    // public static String getParams(Map<String, String> params) {
    //     String sParams = '?';

    //     for (String key : params.keySet()) {
    //         sParams = sParams + key + '=' + params.get(key) + '&';
    //     }

    //     return sParams.substringBeforeLast('&');
    // }

    public static void setTestResponse(String body, Integer statusCode, String status){
        if(Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, new CalloutMockGenerator(body, statusCode, status));
        }
    }
    
    // public static void setTestResponse(Blob body, Integer statusCode, String status){
    //     if(Test.isRunningTest()){
    //         Test.setMock(HttpCalloutMock.class, new CalloutMockGenerator(body, statusCode, status));
    //     }
    // }

    // public static void setTestResponse(String body, Integer statusCode, String status, String namedCredentialToken){
    //     if(Test.isRunningTest()){
    //         Test.setMock(HttpCalloutMock.class, new CalloutMockGenerator(body, statusCode, status, namedCredentialToken));
    //     }
    // }
    
}