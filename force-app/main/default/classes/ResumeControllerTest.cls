@IsTest
public class ResumeControllerTest {

    @IsTest
    static void shouldCreateSkills() {
        
        String skillsList = '[{"proficiency":"Expert","technology":"Siebel CRM"},{"proficiency":"Advanced","technology":"Salesforce"},{"proficiency":"Advanced","technology":"Lightning Web Components (LWC)"},{"proficiency":"Advanced","technology":"Apex"},{"proficiency":"Intermediate","technology":"C#"},{"proficiency":"Intermediate","technology":"ASP.NET"},{"proficiency":"Advanced","technology":"Web Services Development"},{"proficiency":"Advanced","technology":"Integration Development"},{"proficiency":"Advanced","technology":"Software Testing"},{"proficiency":"Advanced","technology":"Software Support"},{"proficiency":"Advanced","technology":"Agile Methodologies"},{"proficiency":"Intermediate","technology":"Project Management"},{"proficiency":"Expert","technology":"CRM Implementation"},{"proficiency":"Intermediate","technology":"Order Management Systems"},{"proficiency":"Intermediate","technology":"Product Configuration"},{"proficiency":"Basic","technology":"Network Fundamentals"},{"proficiency":"Basic","technology":"Printing and Imaging Fundamentals"},{"proficiency":"Basic","technology":"Corporate Content Management Systems"},{"proficiency":"Intermediate","technology":"Desktop Management Systems"},{"proficiency":"Intermediate","technology":"Database Management"}]';

        Candidate__c candidate = new Candidate__c();
        candidate.Email__c = 'henriquebarretohbo@gmail.com';
        candidate.First_Name__c = 'Henrique';
        candidate.Last_Name__c = 'Oliveira';
        insert candidate;

        Test.startTest();
            ResumeController.createSkills(skillsList, candidate.Id);
        Test.stopTest();

        System.Assert(true);

    }

}