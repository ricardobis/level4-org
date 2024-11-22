@isTest
public with sharing class RunOpenNewsletterReportTest {
    @isTest(SeeAllData=true)
    static void testExecute() {
        SchedulableContext sc = null;
        Test.startTest();
        RunOpenNewsletterReport.execute(sc);
        Test.stopTest();

        System.assert(true);
    }
}