@IsTest 
private with sharing class CalculationTest {
    static String dateStr = Datetime.now().format('YYYY-MM-dd');
    static Decimal totalSumWithDiscount = 34567;
    static String discType = 'Automatic';
    static String expBody = 'Sent from your Twilio trial account - Thank you for the purchase!';
    static String ph = '+380731826224';
    static String expFrom = '+12055518213';
    
    @TestSetup
    static void setup(){
        Contact cont = new Contact (LastName = 'Black', Total_Amount__c = 0);
        insert cont;
        List<Item__c> itemList = new List<Item__c>();
        for (Integer i=0;i<5;i++){
            itemList.add(new Item__c(Name = 'Asus Prime '+i));
        }
        insert itemList;
    }
    static CalculationController.ItemWrapper createWrapper(){
        CalculationController.ItemWrapper itmWrapp = new CalculationController.ItemWrapper();
        itmWrapp.itemName = 'Asus Prime 1';
        itmWrapp.itemDiscount = 25;
        itmWrapp.itemPrice = 564;
        itmWrapp.itemQuantity = 3;
        return itmWrapp;
    }

    @IsTest private static void saveOrderTest(){
        Contact cont = [SELECT Id FROM Contact];
        CalculationController.ItemWrapper itmWrapp = createWrapper();
        List<CalculationController.ItemWrapper> itmList = new List<CalculationController.ItemWrapper>();
        itmList.add(itmWrapp);
        Test.startTest();
            try {
                CalculationController.saveOrderMethod(cont.Id, itmList, totalSumWithDiscount, dateStr, discType);
            } catch (Exception e) {
                System.debug('exception: '+e);
            }
        Test.stopTest();
        Integer purch = [SELECT COUNT() FROM Purchase__c];
        Integer purchItems = [SELECT COUNT() FROM Purchase_Item__c ];

        System.assertEquals(1, purch);
        System.assertEquals(1, purchItems);

    }
    @isTest static void smsSendingTest() {

        Test.setMock(HttpCalloutMock.class, new SendSmsCalloutMock()); 
        Test.startTest();
            String jsonInput = CalculationController.sendSms(ph);
        Test.stopTest();
        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(jsonInput);
        System.assertEquals(expBody,m.get('body'));
        System.assertEquals(ph, m.get('to'));
        System.assertEquals(expFrom, m.get('from'));
    }
}