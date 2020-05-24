({
    doInit: function (component, event, helper) {
        helper.setWrapperList(component, event, helper);

    },
    getDiscountFieldValue: function (component, event, helper) {
        var displayField = event.getParam("discTypeEvt");
        component.set("v.HasManualDiscountField", displayField);
    },
    addRow: function (component, event, helper) {
        var ItemRows = component.get("v.ItemRows");
        ItemRows.push({
            'itemName': '',
            'itemQuantity': '',
            'itemPrice': '',
            'itemDiscount': ''
        });
        component.set("v.ItemRows", ItemRows);
        getDiscountFieldValue();
        component.set((component.find("itemRow").get("v.HasManualDiscountField")), component.get("v.HasManualDiscountField"));

    },
    removeDeletedRow: function (component, event, helper) {
        var index = event.getParam("indexVar");
        var childItemType = event.getParam("itemType");
        var parItemType = component.get("v.ItemType");
        if (childItemType == parItemType) {
            var ItemRows = component.get("v.ItemRows");
            ItemRows.splice(index, 1);
            component.set("v.ItemRows", ItemRows);
        }
    }
})