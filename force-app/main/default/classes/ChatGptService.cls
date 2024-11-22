public class ChatGptService {

    public static String summarizeText(String inputText) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        // Setting the Request Properties
        request.setEndpoint('callout:OpenAI_Completions');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setTimeout(120000);
        
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
                   return content;
                } else {
                    return 'No summarization received.';
                }
            } else {
                return 'Error: ' + response.getStatus() + ' - ' + response.getBody();
            }
        } catch (Exception e) {
            return 'Exception: ' + e.getMessage();
        }
    }

    public static String skillsList(String inputText) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        // Setting the Request Properties
        request.setEndpoint('callout:OpenAI_Completions');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setTimeout(120000);
        
        // Formatting the body of the request
        String requestBody = JSON.serialize(new Map<String, Object>{
            'model' => 'gpt-4-turbo', // Adjust based on the model you intend to use
            'messages' => new List<Map<String, String>>{
                new Map<String, String>{
                    'role' => 'system',
                    'content' => 'You are an analyst that extract info.'
                },
                new Map<String, String>{
                    'role' => 'user',
                    'content' => 'Generate a plain text with a list of 20 tech skills and their level with the list property named \'skills\', each skill property named \'technology\', each property level called \'proficiency\', without indentation and in a JSON object structure but without any formatting for the following text: ' + inputText
                }
            },
            'max_tokens' => 600,
            'temperature' => 0.5
        });
        
        request.setBody(requestBody);
        
        try {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {

                Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                List<Object> choices = (List<Object>) jsonResponse.get('choices');
                
                if (!choices.isEmpty()) {
                   Map<String, Object> firstChoice = (Map<String, Object>) choices[0];
                   Map<String, Object> message = (Map<String, Object>) firstChoice.get('message');
                   String content = (String) message.get('content');
                   System.debug(' #### content ' + content);

                   // Parse JSON string into a map
                    Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(content);
                    System.debug(' #### jsonMap ' + jsonMap);

                    // Get the list of skills from JSON
                    // List<Map<String, Object>> skills = (List<Map<String, Object>>) jsonMap.get('skills');
                    List<Object> skills = (List<Object>) jsonMap.get('skills');
                    System.debug(' #### skills ' + skills);

                    List<Map<String, Object>> skillsMap = new List<Map<String, Object>>();

                    for (Object skill : skills) {
                        // System.debug(' #### skill name ' + (String)skill.get('skill'));
                        Map<String, Object> skillMap = (Map<String, Object>) skill;
                        System.debug(' #### skillMap ' + skillMap);
                        System.debug(' #### skillMap technology ' + (String) skillMap.get('technology'));
                        System.debug(' #### skillMap proficiency ' + (String) skillMap.get('proficiency'));
                        skillsMap.add(skillMap);
                    }
                    
                    System.debug(' #### skillsMap ');
                    System.debug(skillsMap);
                    return JSON.serialize(skillsMap);
                } else {
                    return 'No list received.';
                }
            } else {
                return 'Error: ' + response.getStatus() + ' - ' + response.getBody();
            }
        } catch (Exception e) {
            return 'Exception: ' + e.getMessage();
        }
    }


}