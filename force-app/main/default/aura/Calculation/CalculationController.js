({
    saveOrder: function (component, event, helper) {
        helper.saveOrderDetails(component);
        helper.sendMessage(component);
    },
    displayContFields: function (component, event) {
        var params = event.getParam("arguments");
        if (params) {
            var contId = params.contId;
        }

        let action = component.get("c.getContactFields");
        action.setParams({ contactId: contId });

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var arrayMapKeys = [];
                for (var key in result) {
                    arrayMapKeys.push({ key: key, value: result[key] });
                }
                component.set("v.contactFieldsList", arrayMapKeys);

            }
        });
        $A.enqueueAction(action);
    },
})