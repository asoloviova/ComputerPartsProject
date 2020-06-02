({
    contactNameOutput: function (component) {
        let con = JSON.parse(component.find("purchaseSetUp").get("v.contact"));
        if (con != undefined) {
            component.find("calculation").set("v.contact", con);
        }
    },
    prepareList: function (component, event, helper) {
        let fullList = [];
        let procRows = component.find("processors").get("v.itemRows");
        let ramsRows = component.find("rams").get("v.itemRows");
        let motherboardsRows = component.find("motherboards").get("v.itemRows");
        let videocardsRows = component.find("videocards").get("v.itemRows");
        Array.prototype.push.apply(fullList, procRows);
        Array.prototype.push.apply(fullList, ramsRows);
        Array.prototype.push.apply(fullList, motherboardsRows);
        Array.prototype.push.apply(fullList, videocardsRows);
        let itemNames = [];
        for (let i = 0; i < fullList.length; i++) {
            if (fullList[i].itemName) {
                itemNames.push(fullList[i].itemName);
            }
        }

        if (fullList.length && itemNames.length) {
            component.set("v.displayCalculation", true);
        } else {
            component.set("v.displayCalculation", false);
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                message: "Add at least one item!"
            });
            toastEvent.fire();
        }

        component.find("calculation").set("v.chosenItemsList", fullList);
        let totalSum = 0;
        let totalSumWithDiscount = 0;
        for (let i = 0; i < fullList.length; i++) {
            totalSum += (fullList[i].itemPrice) * fullList[i].itemQuantity;
            totalSumWithDiscount += fullList[i].itemPrice * fullList[i].itemQuantity * (100 - fullList[i].itemDiscount) / 100;
        }
        component.find("calculation").set(("v.totalSum"), totalSum);
        component.find("calculation").set(("v.totalSumWithDiscount"), totalSumWithDiscount);

    }
})