@isTest
public class CampaignStatusTriggerTest {
    
    @isTest
    static void testCampaignStatusTrigger() {
        // Create test Campaign
        Campaign testCampaign = new Campaign(Name = 'Test Campaign', Status = 'In Progress');
        insert testCampaign;

        // Create test Lead
        Lead testLead = new Lead(LastName = 'Test Lead', Company = 'Test Company', Status = 'New');
        insert testLead;

        // Create test Campaign Member
        CampaignMember testCampaignMember = new CampaignMember(CampaignId = testCampaign.Id, LeadId = testLead.Id, Status = 'Sent');
        insert testCampaignMember;

        // Update Campaign status to 'Completed'
        testCampaign.Status = 'Completed';
        update testCampaign;

        // Query the updated Lead
        Lead updatedLead = [SELECT Id, Status FROM Lead WHERE Id = :testLead.Id];

        // Assert that the Lead status has been updated to 'Working'
        System.assertEquals('Working', updatedLead.Status);
    }
}