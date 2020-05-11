({
    doInit: function (component, event, helper) {
        var action = component.get("c.getContactsPicklist");
        action.setCallback(this, function (response) {
            var allValues = response.getReturnValue();
            component.set("v.ContactPick", allValues);
        });
        $A.enqueueAction(action);
    }
})