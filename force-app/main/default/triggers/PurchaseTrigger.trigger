trigger PurchaseTrigger on Purchase__c (after insert, after update) {

    if (Trigger.IsAfter) {
        if (Trigger.isInsert) { 
            PurchaseTriggerHandler.purchaseDataSetup(Trigger.new);
            PurchaseTriggerHandler.sharePurchWithContactOwner(Trigger.new);
        } 
        if (Trigger.isUpdate) { }
        if (Trigger.isDelete) { }
      }
}