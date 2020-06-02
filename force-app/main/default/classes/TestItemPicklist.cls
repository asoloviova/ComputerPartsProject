@isTest
public class TestItemPicklist {
   @isTest public static void TestOptionWrapper() {
        String lab = 'label';
        String val = 'value';
        ItemPicklistApexController.Option optn = new ItemPicklistApexController.Option(lab, val);
    }
}