({
    doInit: function (component, event, helper) {
        var action = component.get("c.getItemsPicklist");
        action.setParams({ type: component.get("v.ItemType") });
        action.setCallback(this, function (response) {
            var allValues = response.getReturnValue();
            component.set("v.ItemList", allValues);
            helper.getMaxDisc(component, event, helper);
        });

        $A.enqueueAction(action);
    },
    getValueFromEvent: function (component, event) {
        var displayField = event.getParam("itemTypeEvt");
        component.set("v.HasManualDiscountField", displayField);
    },
    uploadDefaultPrice: function (component, event, helper) {
        var item = JSON.parse(component.get("v.ItemListValue"));
        component.set("v.DefaultPrice", item.Price__c);
    },
    deleteRow: function (component, event, helper) {

        var evt = $A.get("e.c:DeleteRowEvent");
        evt.setParams({ "indexVar": component.get("v.RowIndex") }).fire();
    },
    manDiscountCheck: function (component, event, helper) {

        var discInput = component.find("manualDiscount").get("v.value");
        var maxDisc = component.get("v.maxDiscount");
        if (discInput > maxDisc) {
            component.set("v.manDiscount", maxDisc);
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                message: 'Input manual discount less than ' + maxDisc + '%',
            });
            toastEvent.fire();
        }
    }
})
