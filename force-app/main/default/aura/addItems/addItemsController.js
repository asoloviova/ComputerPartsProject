({
    doInit: function (component, actionName, helper) {
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
        console.log(displayField);
        component.set("v.HasManualDiscountField", displayField);

    }
})