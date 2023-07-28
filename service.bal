import ballerina/http;

listener http:Listener lis = check new (9090);

service / on lis {
    resource function get test (http:Caller caller, http:Request req) returns error? {
        http:Response res = new;

        string|http:HeaderNotFoundError header = req.getHeader("x-jwt-assertion");

        if header is string {
            res.setHeader("x-jwt-assertion", header);
        } else {
            res.setHeader("x-jwt-assertion", "not found");
        }
        res.setPayload("Hello, World!");
        check caller->respond(res);
    }
}