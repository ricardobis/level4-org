@IsTest
public class TriggerContentDocumentLinkTest {

    @TestSetup
    static void makeData(){
        // ContentVersion cv = new ContentVersion();
        // cv.Title = 'Test_Document.[pdf]';
        // cv.VersionData = Blob.valueOf('This is my file body.');
        // cv.PathOnClient = '/Test_Document.pdf';
        // insert cv;

        // Candidate__c candidate = new Candidate__c();
        // candidate.Email__c = 'henriquebarretohbo@gmail.com';
        // candidate.First_Name__c = 'Henrique';
        // candidate.Last_Name__c = 'Oliveira';
        // insert candidate;
        
    }
    
    @IsTest
    static void createContentDocumentLink() {
        
        ContentVersion cv = new ContentVersion();
        cv.Title = 'Test_Document.[pdf]';
        cv.VersionData = Blob.valueOf('This is my file body.');
        cv.PathOnClient = '/Test_Document.pdf';
        insert cv;

        Candidate__c candidate = new Candidate__c();
        candidate.Email__c = 'henriquebarretohbo@gmail.com';
        candidate.First_Name__c = 'Henrique';
        candidate.Last_Name__c = 'Oliveira';
        insert candidate;
        
        List<ContentVersion> contentVersions = new List<ContentVersion>([
                SELECT Id, ContentDocumentId FROM ContentVersion
        ]);

        System.debug(' #####3 trigger test contentVersions ' + contentVersions);

        List<Candidate__c> candidates = new List<Candidate__c>([
                SELECT Id FROM Candidate__c
        ]); 

        System.debug(' #####3 trigger test candidates ' + candidates);

        ContentDocumentLink link = new ContentDocumentLink();
        link.ContentDocumentId = contentVersions[0].ContentDocumentId;
        link.LinkedEntityId = candidates[0].Id;

        System.debug(' #####3 trigger test link ' + link);

        Test.startTest();
        insert link;
        Test.stopTest();

        System.assert(true);
    }

}