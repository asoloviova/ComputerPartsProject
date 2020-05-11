({
    doInit: function (component, event, helper) {
        var action = component.get("c.getItemsPicklist");
        action.setCallback(this, function (response) {
            var allValues = response.getReturnValue();
            component.set("v.ItemList", allValues);
        });
        $A.enqueueAction(action);
    }
})