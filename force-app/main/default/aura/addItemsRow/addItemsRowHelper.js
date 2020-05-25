({
    getMaxDisc: function (component, event, helper) {
        var getMaxDisc = component.get("c.getMaxCustomDiscount");
        getMaxDisc.setCallback(this, function (response) {
            var maxDisc = response.getReturnValue();
            component.set("v.maxDiscount", maxDisc);
        });
        $A.enqueueAction(getMaxDisc);
    },
    uploadDefaultPrice: function (component, event, helper) {
        var item = JSON.parse(component.get("v.ItemListValue"));
        component.set("v.ChosenItem.itemPrice", item.Price__c);
    },
    setItemDiscount: function (component, event, helper) {
        var contactDiscount = component.get("v.contactDiscount");
        console.log("contact's disc: " + contactDiscount);
        var hasManualDiscField = component.get("v.HasManualDiscountField");
        var inputtedDiscount = component.get("v.manDiscount");
        if (hasManualDiscField == true) {
            component.set("v.ChosenItem.itemDiscount", inputtedDiscount);
        } else
            component.set("v.ChosenItem.itemDiscount", contactDiscount);
    }
})
