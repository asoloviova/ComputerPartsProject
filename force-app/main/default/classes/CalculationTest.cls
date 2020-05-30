@IsTest 
private with sharing class CalculationTest {
    @IsTest private static void getChosenItemsListTest() {
        CalculationApexController calcController = new CalculationApexController();
        CalculationApexController.ItemWrapper itmWrapp = new CalculationApexController.ItemWrapper();
        CalculationApexController.getChosenItemsList();
    }
    @IsTest private static void saveOrderTest(){
        Contact cont = new Contact (LastName = 'Black', Total_Amount__c = 0);
        insert cont;
        Decimal contTotalAmount = cont.Total_Amount__c;
        String dateStr = Datetime.now().format('YYYY-MM-dd');
        System.debug(dateStr);
        Decimal totalSumWithDiscount = 34567;
        String discType = 'Automatic';
        CalculationApexController.ItemWrapper itmWrapp = new CalculationApexController.ItemWrapper();
        itmWrapp.itemName = 'AMD Ryzen';
        itmWrapp.itemDiscount = 25;
        itmWrapp.itemPrice = 564;
        itmWrapp.itemQuantity = 3;

        List<CalculationApexController.ItemWrapper> itmList = new List<CalculationApexController.ItemWrapper>();
        itmList.add(itmWrapp);
        System.debug('list size: '+ itmList);
        try {
            CalculationApexController.saveOrderMethod(cont.Id, itmList, totalSumWithDiscount, dateStr, discType);
        } catch (Exception e) {
            System.debug('exception: '+e);
            System.debug('list: '+itmList);
        }

    }

}
