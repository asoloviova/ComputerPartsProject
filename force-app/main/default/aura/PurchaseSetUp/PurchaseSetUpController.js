({
    doInit: function (component, event, helper) {
        let action = component.get("c.getContactsPicklist");
        action.setCallback(this, function (response) {
            let allValues = (response.getReturnValue());
            component.set("v.contactPick", allValues);
            let today = new Date();
            component.set("v.purchaseDate", (today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate()));
        });
        $A.enqueueAction(action);

    },
    displayManualDiscountField: function (component, event, helper) {
        let type = component.find("discountTypePicklist").get("v.value");
        let evt = $A.get("e.c:displayManDiscountField");
        evt.setParams({ "discTypeEvt": type == "manual" });
        evt.fire();

    },
    setContactDiscount: function (component, event, helper) {

        let contactValue = JSON.parse(component.get("v.contact"));
        let evt = $A.get("e.c:setDiscountEvent");
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