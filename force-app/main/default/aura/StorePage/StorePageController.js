({
    handleCalculation: function (component, event, helper) {

        let contactPicklist = component.find("purchaseSetUp").find("contactPicklistId");
        if (contactPicklist.get("v.value")) {
            helper.prepareList(component, event, helper);
            helper.contactNameOutput(component, event, helper);
        } else {
            contactPicklist.showHelpMessageIfInvalid();
        }
        let discountType = component.find("purchaseSetUp").find("discountTypePicklist").get("v.value");
        component.find("calculation").set("v.discountType", discountType);
        let purchaseDate = component.find("purchaseSetUp").get("v.purchaseDate");
        component.find("calculation").set("v.purchaseDate", purchaseDate);
    }
})