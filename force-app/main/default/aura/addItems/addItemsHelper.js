({
    setWrapperList: function (component, event, helper) {
        var action = component.get("c.getChosenItemsList");
        action.setCallback(this, function (response) {
            var result = response.getReturnValue();
            component.set("v.ItemRows", result);
        });

        $A.enqueueAction(action);
    }
})