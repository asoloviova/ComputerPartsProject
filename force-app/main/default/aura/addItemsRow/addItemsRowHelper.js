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
})
