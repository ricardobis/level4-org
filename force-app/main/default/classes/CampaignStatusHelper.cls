public class CampaignStatusHelper {
    // Method to update the related Campaign Member Leads
    public static void updateCampaignMemberLeads(List<Id> campaignIds) {
        // Query the related Campaign Members with Lead Ids
        List<CampaignMember> campaignMembersToUpdate = [SELECT Id, LeadId, Status 
                                                        FROM CampaignMember 
                                                        WHERE CampaignId IN :campaignIds 
                                                        AND LeadId != NULL];

        // List to hold Leads to be updated
        List<Lead> leadsToUpdate = new List<Lead>();

        // Iterate through Campaign Members to update the Lead status
        for (CampaignMember cm : campaignMembersToUpdate) {
            // Create a new Lead instance and set the status
            Lead lead = new Lead(Id = cm.LeadId, Status = 'Working');
            leadsToUpdate.add(lead);
        }
        
        // Update the Leads
        if (!leadsToUpdate.isEmpty()) {
            update leadsToUpdate;
        }
    }
}