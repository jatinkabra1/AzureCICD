@IsTest
private class OpportunityTriggerHandlerTest {

    @IsTest
    static void testClosedWonOpportunity() {

        Account acc = new Account(
            Name = 'Test Account'
        );
        insert acc;

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            AccountId = acc.Id,
            StageName = 'Closed Won',
            CloseDate = Date.today()
        );

        Test.startTest();
        insert opp;
        Test.stopTest();

        Opportunity insertedOpp = [
            SELECT Id, Name, StageName, Description
            FROM Opportunity
            WHERE Id = :opp.Id
        ];

        System.assertEquals(
            'This is a closed won opportunity',
            insertedOpp.Description,
            'Description should be updated for Closed Won Opportunity'
        );
    }

    @IsTest
    static void testNonClosedWonOpportunity() {

        Account acc = new Account(
            Name = 'Test Account 2'
        );
        insert acc;

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity 2',
            AccountId = acc.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today()
        );

        Test.startTest();
        insert opp;
        Test.stopTest();

        Opportunity insertedOpp = [
            SELECT Id, Name, StageName, Description
            FROM Opportunity
            WHERE Id = :opp.Id
        ];

        System.assertNotEquals(
            'This is a closed won opportunity',
            insertedOpp.Description,
            'Description should not be updated for non-Closed Won Opportunity'
        );
    }
}