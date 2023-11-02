@isTest
global class EmailMockHttpResponseGenerator implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"status": "Email sent successfully"}');
        res.setStatusCode(200);

        return res;
    }
}





