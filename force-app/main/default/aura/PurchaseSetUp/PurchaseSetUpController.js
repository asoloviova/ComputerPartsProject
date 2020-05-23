({
    doInit: function (component, event, helper) {
        var action = component.get("c.getContactsPicklist");
        action.setCallback(this, function (response) {
            var allValues = (response.getReturnValue());
            console.log(allValues);
            component.set("v.ContactPick", (allValues));
        });
        $A.enqueueAction(action);
    },
    displayManualDiscountField: function (component, event, helper) {
        var type = component.find("discountTypePicklist").get("v.value");

        var evt = $A.get("e.c:DisplayManualDiscountField");
        if (type == "manual") {
            evt.setParams({ "discTypeEvt": true });
        }
        else if (type == "automatic") { evt.setParams({ "discTypeEvt": false }); }
        evt.fire();

    },
    setContactDiscount: function (component, event, helper) {

        var contactValue = JSON.parse(component.get("v.Contact"));
        console.log("disc: " + contactValue.Personal_Discount__c);
        var evt = $A.get("e.c:SetDiscountEvent");
        evt.setParams({ "contactDiscount": contactValue.Personal_Discount__c });
        evt.fire();
    }

}
)