trigger ContactTrigger on Contact (before insert, before update){
    
    ContactTriggerHandler.handle (
        Trigger.isInsert,
        Trigger.isUpdate,
        Trigger.new,
        Trigger.oldMAp
        );
}