({
    contactNameOutput: function (component) {
        var con = JSON.parse(component.find("purchaseSetUp").get("v.Contact"));
        if (con != undefined) {
            component.find("calculation").set("v.Contact", con);
        }
    },
    prepareList: function (component, event, helper) {
        var fullList = [];
        var procRows = component.find("processors").get("v.ItemRows");
        var ramsRows = component.find("rams").get("v.ItemRows");
        var motherboardsRows = component.find("motherboards").get("v.ItemRows");
        var videocardsRows = component.find("videocards").get("v.ItemRows");
        Array.prototype.push.apply(fullList, procRows);
        Array.prototype.push.apply(fullList, ramsRows);
        Array.prototype.push.apply(fullList, motherboardsRows);
        Array.prototype.push.apply(fullList, videocardsRows);
        var itemNames = [];
        for (var i = 0; i < fullList.length; i++) {
            if (fullList[i].itemName) {
                console.log("itm: " + fullList[i].itemName);
                itemNames.push(fullList[i].itemName);
            }

        }

        if (fullList.length && itemNames.length) {
            component.set("v.displayCalculation", true);
        } else {
            component.set("v.displayCalculation", false);
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                message: "Add at least one item!"
            });
            toastEvent.fire();
        }

        component.find("calculation").set("v.chosenItemsList", fullList);
        var totalSum = 0;
        var totalSumWithDiscount = 0;
        for (var i = 0; i < fullList.length; i++) {
            totalSum += (fullList[i].itemPrice) * fullList[i].itemQuantity;
            totalSumWithDiscount += fullList[i].itemPrice * fullList[i].itemQuantity * (100 - fullList[i].itemDiscount) / 100;
        }
        component.find("calculation").set(("v.totalSum"), totalSum);
        component.find("calculation").set(("v.totalSumWithDiscount"), totalSumWithDiscount);

    }
})