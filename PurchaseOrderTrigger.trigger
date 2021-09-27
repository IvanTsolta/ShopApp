/**
 * Created by User on 27.09.2021.
 */

trigger PurchaseOrderTrigger on Purchase_Order__c ( after update, before delete) {
    PurchaseOrderHandler.handle(trigger.new, trigger.oldMap, trigger.operationType );


}