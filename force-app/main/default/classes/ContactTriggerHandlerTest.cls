@IsTest
private class ContactTriggerHandlerTest {

    @IsTest
    static void testSalesContactGetsTitle() {

        Contact con = new Contact(
            LastName = 'Sales Contact',
            Department = 'Sales'
        );

        Test.startTest();
        insert con;
        Test.stopTest();

        Contact result = [
            SELECT Id, Department, Title
            FROM Contact
            WHERE Id = :con.Id
        ];

        System.assertEquals(
            'Sales',
            result.Department,
            'Department should be Sales.'
        );

        System.assertEquals(
            'Sales Representative',
            result.Title,
            'Sales Contact should receive the default Sales Representative title.'
        );
    }

    @IsTest
    static void testNonSalesContact() {

        Contact con = new Contact(
            LastName = 'Marketing Contact',
            Department = 'Marketing'
        );

        Test.startTest();
        insert con;
        Test.stopTest();

        Contact result = [
            SELECT Id, Department, Title
            FROM Contact
            WHERE Id = :con.Id
        ];

        System.assertEquals(
            'Marketing',
            result.Department,
            'Department should be Marketing.'
        );

        System.assertEquals(
            null,
            result.Title,
            'Title should remain blank for non-Sales Contacts.'
        );
    }

    @IsTest
    static void testExistingTitleIsNotOverwritten() {

        Contact con = new Contact(
            LastName = 'Sales Manager',
            Department = 'Sales',
            Title = 'Sales Manager'
        );

        Test.startTest();
        insert con;
        Test.stopTest();

        Contact result = [
            SELECT Id, Department, Title
            FROM Contact
            WHERE Id = :con.Id
        ];

        System.assertEquals(
            'Sales Manager',
            result.Title,
            'Existing Title should not be overwritten.'
        );
    }

    @IsTest
    static void testUpdateDepartmentToSales() {

        Contact con = new Contact(
            LastName = 'Update Contact',
            Department = 'Marketing'
        );

        insert con;

        con.Department = 'Sales';

        Test.startTest();
        update con;
        Test.stopTest();

        Contact result = [
            SELECT Id, Department, Title
            FROM Contact
            WHERE Id = :con.Id
        ];

        System.assertEquals(
            'Sales',
            result.Department,
            'Department should be updated to Sales.'
        );

        System.assertEquals(
            'Sales Representative',
            result.Title,
            'Title should be populated when Department changes to Sales.'
        );
    }
}