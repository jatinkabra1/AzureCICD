@IsTest
private class RatingHot_Test {

    @IsTest
    static void testHotRatingAccounts() {

        // Create test Accounts
        Account hotAccount = new Account(
            Name = 'Hot Account',
            Rating = 'Hot'
        );

        Account coldAccount = new Account(
            Name = 'Cold Account',
            Rating = 'Cold'
        );

        insert new List<Account>{ hotAccount, coldAccount };

        // Query the records so we pass them to the method
        List<Account> accounts = [
            SELECT Id, Name, Rating, Description
            FROM Account
            WHERE Id IN :new Set<Id>{hotAccount.Id, coldAccount.Id}
        ];

        Test.startTest();

        RatingHot.HotRatingAccounts(accounts);

        Test.stopTest();

        // Verify Hot Account was updated
        Account updatedHotAccount = [
            SELECT Id, Rating, Description
            FROM Account
            WHERE Id = :hotAccount.Id
        ];

        System.assertEquals(
            'Hot',
            updatedHotAccount.Rating,
            'Account rating should be Hot'
        );

        System.assertEquals(
            'This is a hot account',
            updatedHotAccount.Description,
            'Hot Account description should be updated'
        );

        // Verify Cold Account was NOT updated
        Account updatedColdAccount = [
            SELECT Id, Rating, Description
            FROM Account
            WHERE Id = :coldAccount.Id
        ];

        System.assertEquals(
            'Cold',
            updatedColdAccount.Rating,
            'Account rating should be Cold'
        );

        System.assertEquals(
            null,
            updatedColdAccount.Description,
            'Cold Account description should remain unchanged'
        );
    }


    @IsTest
    static void testUpdateAccountDescription() {

        // Create Accounts covering different conditions
        Account largeRevenueAccount = new Account(
            Name = 'Large Revenue Account',
            AnnualRevenue = 2000000
        );

        Account largeOrganization = new Account(
            Name = 'Large Organization',
            NumberOfEmployees = 1000
        );

        Account technologyAccount = new Account(
            Name = 'Technology Account',
            Industry = 'Technology'
        );

        Account normalAccount = new Account(
            Name = 'Normal Account',
            Industry = 'Retail',
            AnnualRevenue = 100000,
            NumberOfEmployees = 10
        );

        insert new List<Account>{
            largeRevenueAccount,
            largeOrganization,
            technologyAccount,
            normalAccount
        };

        // Query records
        List<Account> accounts = [
            SELECT Id,
                   Name,
                   Industry,
                   AnnualRevenue,
                   NumberOfEmployees,
                   Description
            FROM Account
            WHERE Id IN :new Set<Id>{
                largeRevenueAccount.Id,
                largeOrganization.Id,
                technologyAccount.Id,
                normalAccount.Id
            }
        ];

        Test.startTest();

       // RatingHot.UpdateAccountDescription(accounts);

        Test.stopTest();

        // Query updated records
        Map<Id, Account> accountMap = new Map<Id, Account>([
            SELECT Id, Name, Description
            FROM Account
            WHERE Id IN :new Set<Id>{
                largeRevenueAccount.Id,
                largeOrganization.Id,
                technologyAccount.Id,
                normalAccount.Id
            }
        ]);

        // Verify Annual Revenue condition
        System.assertEquals(
            'Large Revenue Account',
            accountMap.get(largeRevenueAccount.Id).Description
        );

        // Verify Number of Employees condition
        System.assertEquals(
            'Large Organization',
            accountMap.get(largeOrganization.Id).Description
        );

        // Verify Industry condition
        System.assertEquals(
            'Technology Account',
            accountMap.get(technologyAccount.Id).Description
        );

        // Verify account that doesn't meet any condition
        System.assertEquals(
            null,
            accountMap.get(normalAccount.Id).Description
        );
    }
}