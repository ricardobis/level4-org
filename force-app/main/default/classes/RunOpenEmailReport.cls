public without sharing class RunOpenEmailReport implements Schedulable {
        
    public static void execute(SchedulableContext sc) {
        List <Report> reportList = [SELECT Id,DeveloperName FROM Report WHERE DeveloperName = 'All_Email_Openings_Report_WiM'];
        String reportId = (String)reportList.get(0).get('Id');

        Reports.reportResults results = Reports.ReportManager.runReport(reportId, true);
        Reports.Dimension dim = results.getGroupingsDown();
        List<Reports.GroupingValue> groupingVals = dim.getGroupings();

        Set<String> emails = new Set<String>();

        for(Reports.GroupingValue item : groupingVals) {
            emails.add((String)item.getValue());
        }

        List<Lead> leads = [SELECT Id, Email FROM Lead WHERE Email IN :emails AND FirstContactEmailOpened__c = false AND IsConverted = false];
        for(Lead l : leads) {
            l.FirstContactEmailOpened__c = true;
        }

        update leads;
    }
}