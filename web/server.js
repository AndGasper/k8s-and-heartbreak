const http = require("http");

const handleRequest = function(request, response) {
    const { url } = request;
    console.log(`Received request for ${url}`);
    response.end("Why would you make calls out the blue?");
}

const server = http.createServer(handleRequest);
server.listen(8080);