({
    doInit: function (component, event, helper) {
        var action = component.get("c.getContactsPicklist");
        action.setCallback(this, function (response) {
            var allValues = response.getReturnValue();
            component.set("v.ContactPick", allValues);
        });
        $A.enqueueAction(action);
    },
    displayManualDiscountField: function (component, event, helper) {
        var type = component.find("discountTypePicklist").get("v.value");

        var evt = $A.get("e.c:DisplayManualDiscountField");
        if (type == "automatic") {
            evt.setParams({ "itemTypeEvt": false });
        }
        else { evt.setParams({ "itemTypeEvt": true }); }
        evt.fire();

    }

}
)