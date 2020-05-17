({
    getMaxDisc: function (component, event, helper) {
        var getMaxDisc = component.get("c.getMaxCustomDiscount");
        getMaxDisc.setCallback(this, function (response) {
            var maxDisc = response.getReturnValue();
            component.set("v.maxDiscount", maxDisc);
        });
        $A.enqueueAction(getMaxDisc);
    }
})
