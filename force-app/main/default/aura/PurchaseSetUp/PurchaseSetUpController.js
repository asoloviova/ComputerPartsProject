({
    doInit: function (component, event, helper) {
        var action = component.get("c.getContactsPicklist");
        action.setCallback(this, function (response) {
            var allValues = response.getReturnValue();
            console.log('allValues -- >> ' + allValues);
            component.set("v.ContactPick", allValues);
        });
        $A.enqueueAction(action);
    }
})