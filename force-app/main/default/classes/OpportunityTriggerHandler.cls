public with sharing class OpportunityTriggerHandler {
    
    public static void handleBeforeInsertUpdate( List<Opportunity> newOpportunities , Map<Id, Opportunity> oldMapOpportunities){

        for (Opportunity opp : newOpportunities) {
            if (opp.StageName == 'Closed Won' && (oldMapOpportunities == null || oldMapOpportunities.get(opp.Id).StageName != 'Closed Won')) {
               opp.Description = 'This opportunity has been won!';        }
        }
    }

}