({
    getMaxDisc: function (component, event, helper) {
        let getMaxDisc = component.get("c.getMaxCustomDiscount");
        getMaxDisc.setCallback(this, function (response) {
            let maxDisc = response.getReturnValue();
            component.set("v.maxDiscount", maxDisc);
        });
        $A.enqueueAction(getMaxDisc);
    },
    uploadDefaultPrice: function (component, event, helper) {
        let item = JSON.parse(component.get("v.itemListValue"));
        component.set("v.chosenItem.itemPrice", item.Price__c);
    },
    setItemDiscount: function (component, event, helper) {
        let contactDiscount = component.get("v.contactDiscount");
        let hasManualDiscField = component.get("v.hasManualDiscountFiled");
        let inputtedDiscount = component.get("v.manDiscount");
        if (hasManualDiscField == true) {
            component.set("v.chosenItem.itemDiscount", inputtedDiscount);
        } else
            component.set("v.chosenItem.itemDiscount", contactDiscount);
    }
})