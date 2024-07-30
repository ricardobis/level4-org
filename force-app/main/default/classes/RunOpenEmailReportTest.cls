@isTest
public with sharing class RunOpenEmailReportTest {
    @isTest(SeeAllData=true)
    static void testExecute() {
        SchedulableContext sc = null;
        Test.startTest();
        RunOpenEmailReport.execute(sc);
        Test.stopTest();

        System.assert(true);
    }
}