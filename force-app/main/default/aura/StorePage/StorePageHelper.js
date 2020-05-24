({
    contactNameOutput: function (component) {
        var con = JSON.parse(component.find("purchaseSetUp").get("v.Contact"));
        if (con != undefined) {
            console.log("con: " + con.Name);
            component.find("calculation").set("v.Contact", con.Name);
        }
    },
    prepareList: function (component, event, helper) {
        var procRows = component.find("processors").get("v.ItemRows");
        var ramsRows = component.find("rams").get("v.ItemRows");
        var motherboardsRows = component.find("motherboards").get("v.ItemRows");
        var videocardsRows = component.find("videocards").get("v.ItemRows");
        var fullList = [];
        for (var i = 0; i < procRows.length; i++) {
            fullList.push({
                itemName: procRows[i].itemName,
                itemQuantity: procRows[i].itemQuantity,
                itemPrice: procRows[i].itemPrice,
                itemDiscount: procRows[i].itemDiscount
            });
        }
        for (var i = 0; i < ramsRows.length; i++) {
            fullList.push({
                itemName: ramsRows[i].itemName,
                itemQuantity: ramsRows[i].itemQuantity,
                itemPrice: ramsRows[i].itemPrice,
                itemDiscount: ramsRows[i].itemDiscount
            });
        }
        for (var i = 0; i < motherboardsRows.length; i++) {
            fullList.push({
                itemName: motherboardsRows[i].itemName,
                itemQuantity: motherboardsRows[i].itemQuantity,
                itemPrice: motherboardsRows[i].itemPrice,
                itemDiscount: motherboardsRows[i].itemDiscount
            });
        }
        for (var i = 0; i < videocardsRows.length; i++) {
            fullList.push({
                itemName: videocardsRows[i].itemName,
                itemQuantity: videocardsRows[i].itemQuantity,
                itemPrice: videocardsRows[i].itemPrice,
                itemDiscount: videocardsRows[i].itemDiscount
            });
        }
        component.find("calculation").set("v.chosenItemsList", fullList);
        var totalSum = 0;
        var totalSumWithDiscount = 0;
        for (var i = 0; i < fullList.length; i++) {
            totalSum += fullList[i].itemPrice;
            totalSumWithDiscount += (fullList[i].itemPrice) * (100 - fullList[i].itemDiscount) / 100;
        }
        component.find("calculation").set(("v.totalSum"), totalSum);
        component.find("calculation").set(("v.totalSumWithDiscount"), totalSumWithDiscount);

        // var action = component.get("c.combineItemLists");
        // action.setParams({
        //     procRows: procRows,
        //     ramsRows: ramsRows,
        //     motherboardsRows: motherboardsRows,
        //     videocardsRows: videocardsRows
        // });
        // action.setCallback(this, function (response) {
        //     var response = response.getReturnValue();
        //     console.log("response: " + response);
        //     component.find("calculation").set("v.chosenItemsList", response);
        // });
        // $A.enqueueAction(action);
    }
})