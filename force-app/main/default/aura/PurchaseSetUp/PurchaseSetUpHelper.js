({
    setContDiscount: function (component, event) {
        let contactValue = JSON.parse(component.get("v.contact"));
        let evt = $A.get("e.c:setDiscountEvent");
        if (contactValue.Personal_Discount__c) {
            evt.setParams({ "contactDiscount": contactValue.Personal_Discount__c });
        }
        else {
            evt.setParams({ "contactDiscount": 0 });
        }
        evt.fire();
    }
})