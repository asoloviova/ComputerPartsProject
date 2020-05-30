({
    handleCalculation: function (component, event, helper) {

        var contactPicklist = component.find("purchaseSetUp").find("contactPicklistId");
        if (contactPicklist.get("v.value")) {
            helper.prepareList(component, event, helper);
            helper.contactNameOutput(component, event, helper);
        } else {
            contactPicklist.showHelpMessageIfInvalid();
        }
        var discountType = component.find("purchaseSetUp").find("discountTypePicklist").get("v.value");
        component.find("calculation").set("v.discountType", discountType);
        var purchaseDate = component.find("purchaseSetUp").get("v.purchaseDate");
        component.find("calculation").set("v.purchaseDate", purchaseDate);
    }
})