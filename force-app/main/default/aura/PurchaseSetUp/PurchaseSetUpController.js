({
    doInit: function (component, event, helper) {
        var action = component.get("c.getContactsPicklist");
        action.setCallback(this, function (response) {
            var allValues = (response.getReturnValue());
            console.log(allValues);
            component.set("v.ContactPick", (allValues));
        });
        $A.enqueueAction(action);
        var today = new Date();
        component.set("v.purchaseDate", (today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate()));
    },
    displayManualDiscountField: function (component, event, helper) {
        var type = component.find("discountTypePicklist").get("v.value");

        var evt = $A.get("e.c:DisplayManualDiscountField");
        if (type == "manual") {
            evt.setParams({ "discTypeEvt": true });
        }
        else if (type == "automatic") {
            evt.setParams({ "discTypeEvt": false });
        }
        evt.fire();

    },
    setContactDiscount: function (component, event, helper) {

        var contactValue = JSON.parse(component.get("v.Contact"));
        console.log("disc in purch: " + contactValue.Personal_Discount__c);
        var evt = $A.get("e.c:SetDiscountEvent");
        if (contactValue.Personal_Discount__c) {
            evt.setParams({ "contactDiscount": contactValue.Personal_Discount__c });
        }
        else {
            evt.setParams({ "contactDiscount": 0 });
        }
        evt.fire();
    }

}
)