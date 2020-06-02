({
    saveOrderDetails: function (component) {
        let contact = component.get("v.contact");
        let list = component.get("v.chosenItemsList");
        let totalSum = component.get("v.totalSumWithDiscount");
        let date = component.get("v.purchaseDate");
        let discountType = component.get("v.discountType");

        let action = component.get("c.saveOrderMethod");
        action.setParams({
            "contId": contact.Id,
            "chosenItems": list,
            "totalSumWithDiscount": totalSum,
            "purchDate": date,
            "discountType": discountType
        });
        action.setCallback(this, function (response) {
            let state = response.getState();
            let toastEvent = $A.get("e.force:showToast");
            if (state === "SUCCESS") {
                toastEvent.setParams({
                    type: "success",
                    message: "Successfully saved!"
                });
            } else if (state === "ERROR") {
                let errors = response.getError();
                toastEvent.setParams({

                    "title": "ERROR!",
                    "message": errors[0].message,
                    "type": error
                });
            }
            toastEvent.fire();
        });
        $A.enqueueAction(action);
    }
})