({
    doInit: function (component) {
        var action = component.get("c.getItemsPicklist");
        action.setParams({ type: component.get("v.ItemType") });
        action.setCallback(this, function (response) {
            var allValues = response.getReturnValue();
            component.set("v.ItemList", allValues);
        });
        $A.enqueueAction(action);

    },
    getValueFromEvent: function (component, event) {
        var displayField = event.getParam("itemTypeEvt");
        component.set("v.HasManualDiscountField", displayField);
    },
    uploadDefaultPrice: function (component, event, helper) {

        var itmName = component.find("itemPicklist").get("v.value");
        console.log(itmName);
        var action = component.get("c.getItemsPrice");
        action.setParams({ name: itmName });
        action.setCallback(this, function (response) {
            var priceResult = response.getReturnValue();
            component.set("v.DefaultPrice", priceResult);
        });
        $A.enqueueAction(action);
    },
    deleteRow: function (component, event, helper) {

        var evt = $A.get("e.c:DeleteRowEvent");
        evt.setParams({ "indexVar": component.get("v.RowIndex") }).fire();
    },
})
