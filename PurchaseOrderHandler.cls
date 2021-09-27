/**
 * Created by User on 27.09.2021.
 */

public with sharing class PurchaseOrderHandler {
    public static void handle(List<Purchase_Order__c>  newPurchaseOrders,Map<Id,Purchase_Order__c> oldPurchaseOrdersByIds, TriggerOperation operationType){
            switch on operationType{
                when AFTER_UPDATE{
                    List<Purchase_Order__c> complitedOrders =  new List<Purchase_Order__c>();
                    List<Purchase_Order__c> unComplitedOrders =  new List<Purchase_Order__c>();
                    for (Purchase_Order__c order : newPurchaseOrders) {
                        Purchase_Order__c oldOrder = oldPurchaseOrdersByIds.get(order.Id);
                            if (order.Status__c == 'Completed'&& oldOrder.Status__c != order.Status__c) {
                                complitedOrders.add(order);

                            }
                            if (order.Status__c !='Completed' && oldOrder.Status__c != order.Status__c){
                                unComplitedOrders.add(order);
                            }
                    }
                    List<Product2> productsToUpdate = new List<Product2>();
                    for (Purchase_Order_Line__c poLine: complitedOrders) {
                        productsToUpdate.add(new Product2(Id = poLine.Product__c, Quantity_In_Stock__c = poLine.Product__r.Quantity_In_Stock__c + poLine.Quantity__c));
                                if(!complitedOrders.isEmpty()){
                        List<Purchase_Order_Line__c> complitedOrders = [SELECT Id, Product__c, Quantity__c FROM Purchase_Order_Line__c WHERE Purchase_Order__c IN :complitedOrders ];

                    }
                        }
                    update productsToUpdate;
                        List<Product2> productsToMinus = new List<Product2>();
                    for (Purchase_Order_Line__c poLine: unComplitedOrders) {
                        productsToMinus.add(new Product2(Id = poLine.Product__c, Quantity_In_Stock__c = poLine.Product__r.Quantity_In_Stock__c + poLine.Quantity__c));
                    if(!unComplitedOrders.isEmpty()){
                        List<Purchase_Order_Line__c> unComplitedOrders = [SELECT Id, Product__c, Quantity__c FROM Purchase_Order_Line__c WHERE Purchase_Order__c IN :unComplitedOrders ];
                      }
                    }
                    update productsToMinus;
                }
                when BEFORE_DELETE{
                    for (Purchase_Order__c purchaseOrder: newPurchaseOrders){
                        if (purchaseOrder.Status__c == 'Completed') {
                            purchaseOrder.addError('You can not delete a Completed Purchase Order');
                        }
                    }
                }
            }
    }
}

