public without sharing class ResumeController {

    @Future(callout=true)
    public static void assyncSetSummary(String inputContentDocumentLinkId) {
        
        ContentDocumentLink cdl = [SELECT FIELDS(STANDARD) FROM ContentDocumentLink WHERE Id = :inputContentDocumentLinkId WITH SECURITY_ENFORCED LIMIT 1];
        // revisar necessidade da query acima, talvez seja melhor adicionar o candidate id no input do method para evitar essa query

        String contentDocumentId = cdl.ContentDocumentId;
        String candidateId = cdl.LinkedEntityId;

        ContentVersion cv = [SELECT FIELDS(STANDARD) FROM ContentVersion WHERE ContentDocumentId = :contentDocumentId WITH SECURITY_ENFORCED LIMIT 1 ];

        String extractedText = PDFRestService.extractText(cv);

        System.debug(' #### ResumeController.assyncSetSummary extractedText ');
        System.debug(extractedText);

        String summarizedText = ChatGptService.summarizeText(extractedText);

        System.debug(' #### ResumeController.assyncSetSummary summarizedText');
        System.debug(summarizedText);

        String skillsList = ChatGptService.skillsList(extractedText);

        System.debug(' #### ResumeController.assyncSetSummary skillsList');
        System.debug(skillsList);


        //SEPARAR CADA CHAMADA DE WEB SERVICE EM METHODOS DIFERENTES DENTRO DA RESUMECONTROLLER????
        //ACHO QUE SERA NECESSARIO PARA CRIAR OS METHODOS DE TESTE E CONSEGUIR CRIAR O CALLOUT DIFERENTE EM CADA UM


        createSkills(skillsList, candidateId);

        Candidate__c candidate = [SELECT Id FROM Candidate__c WHERE Id = :candidateId WITH SECURITY_ENFORCED LIMIT 1];
        candidate.Summary__c = summarizedText;
        
        update candidate;       


    }

    public static void createSkills(String skillsList, String candidateId) {   

        List<Schema.PicklistEntry> seniorityPicklistEntries = Skill__c.Seniority__c.getDescribe().getPicklistValues();

        List<String> levels = new List<String>();
            
        for(Schema.PicklistEntry picklistEntry : seniorityPicklistEntries) {
            levels.add(picklistEntry.getValue());
        }



        List<Object> skills = (List<Object>) JSON.deserializeUntyped(skillsList);

        System.debug(' #### createSkills skills');
        System.debug(skills);

        List<Map<String, Object>> skillsMap = new List<Map<String, Object>>();

        for (Object skill : skills) {
            // System.debug(' #### skill name ' + (String)skill.get('skill'));
            Map<String, Object> skillMap = (Map<String, Object>) skill;
            System.debug(' #### createSkills skillMap ' + skillMap);
            System.debug(' #### createSkills skillMap technology ' + (String) skillMap.get('technology'));
            System.debug(' #### createSkills skillMap proficiency ' + (String) skillMap.get('proficiency'));
            skillsMap.add(skillMap);

            // if (techs.contains((String) skillMap.get('technology')) && levels.contains((String) skillMap.get('proficiency')) ) {
                //throw new System.UnexpectedException('Technology not allowed');
                Skill__c skillRecord = new Skill__c();
                skillRecord.Candidate__c = candidateId;
                skillRecord.Technology__c = (String) skillMap.get('technology');
                skillRecord.Seniority__c = (String) skillMap.get('proficiency');

                insert skillRecord;
            // }
        }
        
        System.debug(' #### createSkills skillsMap ');
        System.debug(skillsMap);

    }

}