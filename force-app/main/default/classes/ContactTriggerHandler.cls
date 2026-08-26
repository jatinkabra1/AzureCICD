public with sharing class ContactTriggerHandler {

    public static void handle(Boolean isInsert,Boolean isUpdate,List<Contact> newContacts, Map<Id, Contact> oldContactMap) {

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