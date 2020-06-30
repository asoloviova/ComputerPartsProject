@IsTest
global class SendSmsCalloutMock implements HttpCalloutMock{

    global Integer calls = 0;
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setBody('{"body": "Sent from your Twilio trial account - Thank you for the purchase!", "to": "+380731826224", "from": "+12055518213"}');
        response.setStatusCode(200);
        calls++;
        return response; 
    }
}
