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


}