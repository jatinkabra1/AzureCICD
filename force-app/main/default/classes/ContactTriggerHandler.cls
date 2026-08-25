public with sharing class ContactTriggerHandler {

    public static void handle(List<Contact> newContacts, Map<Id, Contact> oldContactMap, Boolean isInsert,Boolean isUpdate) {

        if (isInsert || isUpdate) {
            setSalesTitle(newContacts);
        }
    }

    private static void setSalesTitle(List<Contact> contacts) {

        for (Contact con : contacts) {

            if (
                con.Department == 'Sales' &&
                String.isBlank(con.Title)
            ) {
                con.Title = 'Sales Representative';
            }
        }
    }
}