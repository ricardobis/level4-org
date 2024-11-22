public class ChatGptFutureClass {
    
    @Future(callout=true)
    public static void assyncSummarizeText(String inputText) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        // Setting the Request Properties
        request.setEndpoint('callout:OpenAI_Completions');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        
        // Formatting the body of the request
        String requestBody = JSON.serialize(new Map<String, Object>{
            'model' => 'gpt-4-turbo', // Adjust based on the model you intend to use
            'messages' => new List<Map<String, String>>{
                new Map<String, String>{
                    'role' => 'user',
                    'content' => 'Summarize the following text: ' + inputText
                }
            },
            'max_tokens' => 600,
            'temperature' => 0.5
        });
        
        request.setBody(requestBody);
        
        try {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                // Parse the JSON response
                Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                List<Object> choices = (List<Object>) jsonResponse.get('choices');
                
                // Extract the summary from the first choice
                if (!choices.isEmpty()) {
                   Map<String, Object> firstChoice = (Map<String, Object>) choices[0];
                   Map<String, Object> message = (Map<String, Object>) firstChoice.get('message');
                   String content = (String) message.get('content');
                //    return content;
                    System.debug(' ### retorno servico ### content');
                    System.debug(content);
                } else {
                    // return 'No summarization received.';
                    System.debug(' ### retorno servico ### else ');
                    System.debug('No summarization received.');
                }
            } else {
                // return 'Error: ' + response.getStatus() + ' - ' + response.getBody();
                System.debug(' ### retorno servico ### response.error');
                System.debug('Error: ' + response.getStatus() + ' - ' + response.getBody());
            }
        } catch (Exception e) {
            // return 'Exception: ' + e.getMessage();
            System.debug(' ### retorno servico ### excepction.getMessage');
            System.debug('Exception: ' + e.getMessage());
        }
    }
}