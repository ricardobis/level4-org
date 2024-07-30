trigger CampaignStatusTrigger on Campaign (after update) {
    // List to hold campaign IDs with status changed to 'Completed'
    List<Id> completedCampaignIds = new List<Id>();
    
    // Iterate through the campaigns to find those with status changed to 'Completed'
    for (Campaign campaign : Trigger.new) {
        if (campaign.Status == 'Completed' && Trigger.oldMap.get(campaign.Id).Status != 'Completed') {
            completedCampaignIds.add(campaign.Id);
        }
    }
    
    // If there are any completed campaigns, call the helper method to update related leads
    if (!completedCampaignIds.isEmpty()) {
        CampaignStatusHelper.updateCampaignMemberLeads(completedCampaignIds);
    }
}