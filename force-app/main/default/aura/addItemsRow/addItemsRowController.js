({
    doInit: function (component, event, helper) {
        var action = component.get("c.getItemsPicklist");
        action.setParams({ type: component.get("v.ItemType") });
        action.setCallback(this, function (response) {
            var allValues = response.getReturnValue();
            component.set("v.ItemList", allValues);
            helper.getMaxDisc(component, event, helper);
        });

        $A.enqueueAction(action);
    },
    getDiscountFieldValue: function (component, event) {
        var displayField = event.getParam("discTypeEvt");
        component.set("v.HasManualDiscountField", displayField);
    },
    setContactDiscount: function (component, event, helper) {
        var contactDiscount = event.getParam("contactDiscount")
        component.set("v.contactDiscount", contactDiscount);
    },
    itemPicklistChange: function (component, event, helper) {
        helper.uploadDefaultPrice(component, event, helper);
        var inputted = JSON.parse(component.get("v.ItemListValue"));
        component.set("v.ChosenItem.itemName", inputted.Name);
        component.set("v.ChosenItem.itemQuantity", component.get("v.chosenQuantity"));

    },
    deleteRow: function (component, event, helper) {

        var evt = $A.get("e.c:DeleteRowEvent");
        evt.setParams({ "indexVar": component.get("v.RowIndex"), "itemType": component.get("v.ItemType") }).fire();
    },
    quantityChange: function (component, event, helper) {
        component.set("v.ChosenItem.itemQuantity", component.find("quantityPicklist").get("v.value"));
    },
    manDiscountCheck: function (component, event, helper) {

        var discInput = component.get("v.manDiscount");
        var maxDisc = component.get("v.maxDiscount");
        if (discInput > maxDisc) {
            component.set("v.manDiscount", maxDisc);
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                message: 'Input manual discount less than ' + maxDisc + '%',
            });
            toastEvent.fire();
        }
        var contactDiscount = component.get("v.contactDiscount");
        console.log("contact's disc: " + contactDiscount);
        var hasManualDiscField = component.get("v.HasManualDiscountField");
        var inputtedDiscount = component.get("v.manDiscount");
        if (hasManualDiscField == false) {
            component.set("v.ChosenItem.itemDiscount", contactDiscount);
        } else if (hasManualDiscField == true && (contactDiscount >= inputtedDiscount))
            component.set("v.ChosenItem.itemDiscount", contactDiscount);
        else component.set("v.ChosenItem.itemDiscount", inputtedDiscount);
    }
})
