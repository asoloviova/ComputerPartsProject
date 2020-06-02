({
    getDiscountFieldValue: function (component, event) {
        let displayField = event.getParam("discTypeEvt");
        component.set("v.hasManualDiscountFiled", displayField);
    },
    setContactDiscount: function (component, event) {
        let contactDiscount = event.getParam("contactDiscount");
        component.set("v.contactDiscount", contactDiscount);
    },
    addRow: function (component, event, helper) {
        let itemRows = component.get("v.itemRows");
        itemRows.push({
            'itemName': '',
            'itemQuantity': '',
            'itemPrice': '',
            'itemDiscount': ''
        });
        component.set("v.itemRows", itemRows);
    },
    removeDeletedRow: function (component, event, helper) {
        let index = event.getParam("indexVar");
        let childitemType = event.getParam("itemType");
        let paritemType = component.get("v.itemType");
        if (childitemType == paritemType) {
            let itemRows = component.get("v.itemRows");
            itemRows.splice(index, 1);
            component.set("v.itemRows", itemRows);
        }
    }
})