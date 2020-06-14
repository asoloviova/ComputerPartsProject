public with sharing class CalculationController {

    @AuraEnabled
    public static void saveOrderMethod(String contId, List<ItemWrapper> chosenItems, Decimal totalSumWithDiscount, 
            String purchDate, String discountType ){
        Date purchaseDate = Date.valueOf(purchDate);
        String discType = discountType.substring(0, 1).toUpperCase() + discountType.substring(1);
        Purchase__c purch = new Purchase__c(Contact__c = contId, Amount__c = totalSumWithDiscount, 
        Purchase_Date__c = purchaseDate, Discount_Type__c = discType);
        insert purch;
        List <Purchase_Item__c> purchItemsList = new List<Purchase_Item__c>();
        for(ItemWrapper chosenItem : chosenItems){
            if (String.isNotBlank(chosenItem.itemName)){
                Item__c item = [SELECT Id, Name FROM Item__c WHERE Name=:chosenItem.itemName];
                purchItemsList.add(new Purchase_Item__c (Discount__c = chosenItem.itemDiscount,
                        Item__c = item.Id, Purchase__c = purch.Id, Quantity__c = chosenItem.itemQuantity));
            }
        }
        insert purchItemsList;
    }

    @AuraEnabled 
    public static String sendSms(String phNumber){            

        Twilio_API__c tAPI = Twilio_API__c.getOrgDefaults();
        String accountSid = tAPI.Account_Sid__c;
        String token = tAPI.Token__c;
        String fromPhNumber = '+12055518213';           
        String smsBody = 'Thank you for the purchase!';        
        HttpRequest req = new HttpRequest();        
        req.setEndpoint('callout:Twilio_API/2010-04-01/Accounts/'+accountSid+'/SMS/Messages.json');
        req.setMethod('POST');        
        String VERSION  = '3.2.0';        
        req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);        
        req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);       
        req.setHeader('Accept', 'application/json');        
        req.setHeader('Accept-Charset', 'utf-8');        
        req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(accountSid+':' +token)));        
        req.setBody('To='+EncodingUtil.urlEncode(phNumber,'UTF-8')+'&From='+EncodingUtil.urlEncode(fromPhNumber,'UTF-8')+'&Body='+smsBody);        
        Http http = new Http();        
        HTTPResponse res = http.send(req);     
		return res.getBody();
    } 

    public class ItemWrapper{
        @AuraEnabled
        public String itemName{get;set;}

        @AuraEnabled
        public Integer itemQuantity{get;set;}

        @AuraEnabled
        public Double itemPrice{get;set;}

        @AuraEnabled
        public Double itemDiscount{get;set;}
    }
}