({
    saveOrder: function (component, event, helper) {
        var contact = component.get("v.Contact");
        var list = component.get("v.chosenItemsList");
        var totalSum = component.get("v.totalSumWithDiscount");
        var date = component.get("v.purchaseDate");
        var discountType = component.get("v.discountType");

        var action = component.get("c.saveOrderMethod");
        action.setParams({
            "contId": contact.Id,
            "chosenItems": list,
            "totalSumWithDiscount": totalSum,
            "purchDate": date,
            "discountType": discountType
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    message: "Successfully saved!"
                });
                toastEvent.fire();
            } else if (state === "ERROR") {
                var errors = response.getError();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "ERROR!",
                    "message": errors[0].message
                });
                toastEvent.fire();

            } else console.log(state);
        });
        $A.enqueueAction(action);

    },
})