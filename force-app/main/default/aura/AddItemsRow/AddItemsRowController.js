({
    doInit: function (component, event, helper) {
        let action = component.get("c.getItemsPicklist");
        action.setParams({ type: component.get("v.itemType") });
        action.setCallback(this, function (response) {
            let allValues = response.getReturnValue();
            component.set("v.itemList", allValues);
            helper.getMaxDisc(component, event, helper);
        });

        $A.enqueueAction(action);
    },
    setContactDiscount: function (component, event, helper) {
        let contactDiscount = event.getParam("contactDiscount");
        component.set("v.contactDiscount", contactDiscount);
        let discountField = component.get("v.hasManualDiscountFiled");
        if (!discountField) {
            component.set("v.chosenItem.itemDiscount", contactDiscount);
        }
    },
    getDiscountFieldValue: function (component, event) {
        let displayField = event.getParam("discTypeEvt");
        component.set("v.hasManualDiscountFiled", displayField);
        let manDiscount = component.get("v.manDiscount");
        if (displayField) {
            component.set("v.chosenItem.itemDiscount", manDiscount);
        }
        else if (!displayField) {
            component.set("v.chosenItem.itemDiscount", component.get("v.contactDiscount"));
        }
    },

    itemPicklistChange: function (component, event, helper) {
        let inputted = JSON.parse(component.get("v.itemListValue"));
        component.set("v.chosenItem.itemName", inputted.Name);
        component.set("v.chosenItem.itemQuantity", component.get("v.chosenQuantity"));
        helper.uploadDefaultPrice(component, event, helper);
        helper.setItemDiscount(component, event, helper);

    },
    deleteRow: function (component, event, helper) {

        let evt = $A.get("e.c:deleteRowEvent");
        evt.setParams({ "indexVar": component.get("v.rowIndex"), "itemType": component.get("v.itemType") }).fire();
    },
    quantityChange: function (component) {
        component.set("v.chosenItem.itemQuantity", component.find("quantityPicklist").get("v.value"));
    },
    manDiscountCheck: function (component, event, helper) {

        let discInput = component.get("v.manDiscount");
        let maxDisc = component.get("v.maxDiscount");
        if (discInput > maxDisc) {
            component.set("v.manDiscount", maxDisc);
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                message: 'Input manual discount less than ' + maxDisc + '%',
            });
            toastEvent.fire();
        }
        let hasManualDiscField = component.get("v.hasManualDiscountFiled");
        let inputtedDiscount = component.get("v.manDiscount");
        if (hasManualDiscField) {
            component.set("v.chosenItem.itemDiscount", inputtedDiscount);
        }
    }
})