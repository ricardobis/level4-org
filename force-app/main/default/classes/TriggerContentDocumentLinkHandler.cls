public without sharing class TriggerContentDocumentLinkHandler {

    public static void createCandidateSummary(List<ContentDocumentLink> cdls) {

        String linkedIdToService = '';
        System.debug('### cdls: ' + cdls);
        System.debug('### cdls size: ' + cdls.size());

        for (ContentDocumentLink link : cdls) {
            String linkedEntityId = link.LinkedEntityId;
            List<Candidate__c> candidates = [SELECT Id FROM Candidate__c WHERE Id = :link.LinkedEntityId];
            if (candidates.size() > 0) {
                // System.debug('### linkedIdToService: ' + candidates[0].Id);
                // linkedIdToService = candidates[0].Id;
                System.debug('### linkedIdToService: ' + link.Id);
                linkedIdToService = link.Id;
            }

        }

        if (!Test.isRunningTest()){
            ResumeController.assyncSetSummary(linkedIdToService);
        }

    }
}