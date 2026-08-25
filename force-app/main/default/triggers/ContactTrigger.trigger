trigger ContactTrigger on Contact (before insert, before update){
    
    ContactTriggerHandler.handler (
        Trigger.isInsert,
        Trigger.isUpdate,
        Trigger.new,
        Trigger.oldMAp
        );
}