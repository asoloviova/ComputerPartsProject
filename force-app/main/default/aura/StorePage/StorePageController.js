({
    handleCalculation: function (component, event, helper) {
        var contactPicklist = component.find("purchaseSetUp").find("contactPicklistId");
        // var purchaseDatePicklist = component.find("purchaseSetUp").find("datePicklist");
        // var processorsItemPicklist = component.find("processors").find("itemRow").find("itemPicklist");
        // var ramsItemPicklist = component.find("rams").find("itemRow").find("itemPicklist");
        // var motherboardsItemPicklist = component.find("motherboards").find("itemRow").find("itemPicklist");
        // var videocardsItemPicklist = component.find("videocards").find("itemRow").find("itemPicklist");
        // console.log(processorsItemPicklist.get("v.value"));

        // if (contactPicklist.get("v.value") && (processorsItemPicklist.get("v.value") || processorsItemPicklist.get("v.value") != "") && ramsItemPicklist.get("v.value") != "" && motherboardsItemPicklist.get("v.value") != "" && videocardsItemPicklist.get("v.value") != "") {
        if (contactPicklist.get("v.value")) {
            helper.contactNameOutput(component, event, helper);
            helper.prepareList(component, event, helper);
        } else {
            contactPicklist.showHelpMessageIfInvalid();
            // purchaseDatePicklist.showHelpMessageIfInvalid();
            // processorsItemPicklist.showHelpMessageIfInvalid();
            // ramsItemPicklist.showHelpMessageIfInvalid();
            // motherboardsItemPicklist.showHelpMessageIfInvalid();
            // videocardsItemPicklist.showHelpMessageIfInvalid();
        }
    }
})