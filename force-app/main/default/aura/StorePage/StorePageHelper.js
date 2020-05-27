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

        component.find("calculation").set("v.chosenItemsList", fullList);
        var totalSum = 0;
        var totalSumWithDiscount = 0;
        for (var i = 0; i < fullList.length; i++) {
            totalSum += (fullList[i].itemPrice) * 1;
            totalSumWithDiscount += (fullList[i].itemPrice) * (100 - fullList[i].itemDiscount) / 100;
        }
        component.find("calculation").set(("v.totalSum"), totalSum);
        component.find("calculation").set(("v.totalSumWithDiscount"), totalSumWithDiscount);

    }
})