({
    addRow: function (component, event, helper) {
        var ItemRows = component.get("v.ItemRows");
        ItemRows.push({
            'sObjectType': 'Purchase_Item__c',
            'Name': '',
            'Item__c': '',
            'Quantity__c': '',
            'Price__c': '',
            'Discount__c': ''
        });
        component.set("v.ItemRows", ItemRows);
    },
    removeDeletedRow: function (component, event, helper) {
        var index = event.getParam("indexVar");
        var ItemRows = component.get("v.ItemRows");
        ItemRows.splice(index, 1);
        component.set("v.ItemRows", ItemRows);
    }
})