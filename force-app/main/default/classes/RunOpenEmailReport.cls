public without sharing class RunOpenEmailReport implements Schedulable {
        
    public static void execute(SchedulableContext sc) {
        Map<String, String> emails = new Map<String, String>();

        List <Report> reportList = [SELECT Id,DeveloperName FROM Report WHERE DeveloperName = 'All_Email_Openings_Report_WiM'];
        String reportId = (String)reportList.get(0).get('Id');

        Reports.reportResults results = Reports.ReportManager.runReport(reportId, true);
        Reports.Dimension dim = results.getGroupingsDown();
        for( Reports.GroupingValue groupingVal : dim.getGroupings()) {
            String factMapKey = groupingVal.getKey() + '!T';    
            Reports.ReportFactWithDetails factDetails = (Reports.ReportFactWithDetails)results.getFactMap().get(factMapKey);
            Reports.SummaryValue sumVal = factDetails.getAggregates()[0];
            emails.put(groupingVal.getlabel(), sumVal.getLabel());
        }

        List<Lead> leads = [SELECT Id, Email FROM Lead WHERE Email IN :emails.keySet() AND IsConverted = false AND Status IN ('New', 'Working') AND Email != NULL];
        for(Lead l : leads) {
            l.FirstContactEmailOpened__c = true;
            l.FirstContactEmailOpenedAmount__c = Integer.valueOf(emails.get(l.Email));
        }

        update leads;
    }
}