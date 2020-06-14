@IsTest
global class SendSmsCalloutMock implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest request) {
        Twilio_API__c tAPI = Twilio_API__c.getOrgDefaults();
        String accountSid = tAPI.Account_Sid__c;
        String token = tAPI.Token__c;
        HttpResponse response = new HttpResponse();
        String VERSION  = '3.2.0';        
        response.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);        
        response.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);       
        response.setHeader('Accept', 'application/json');        
        response.setHeader('Accept-Charset', 'utf-8');        
        response.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(accountSid+':' +token)));     
        response.setBody('{"body": "Sent from your Twilio trial account - Thank you for the purchase!", "to": "+380731826224", "from": "+12055518213"}');
        response.setStatusCode(200);
        return response; 
    }
}
