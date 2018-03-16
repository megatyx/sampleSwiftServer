import PerfectHTTP
import PerfectHTTPServer
import PerfectLib

// Register your own routes and handlers
var routes = Routes()
routes.add(method: .get, uri: "/") {
    request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
        .completed()
}

routes.add(method: .get, uri: "/hello") { request, response in
    if let name = request.param(name: "tyler"), name == "tyler" {
        response.setHeader(.contentType, value: "text/html")
        response.appendBody(string: "<html><title>Hello \(name)!</title><body>Hello, world!</body></html>")
            .completed()
    } else {
        response.setHeader(.contentType, value: "text/html")
        response.appendBody(string: "<html><title>error</title><body>Hello, world!</body></html>")
            .completed()
        
    }
    //    if let foo = request.param(name: "foo", defaultValue: "default foo") {
    //        ...
    //    }
    //let foos: [String] = request.params(named: "foo")
}

routes.add(method: .get, uri: "/json") { request, response in
    response.setHeader(.contentType, value: "application/json")
    let d: [String:Any] = ["a":1, "b":0.1, "c": true, "d":[2, 4, 5, 7, 8]]
    do {
        try response.setBody(json: d)
    } catch {
        //...
    }
    response.completed()
}



routes.add(method: .get, uri: "/tyler") { request, response in
    do {
        let tyler = File(Dir.workingDir.path + "img/me.jpeg")
        let imageSize = tyler.size
        let imageBytes = try tyler.readSomeBytes(count: imageSize)
        response.setHeader(.contentType, value: MimeType.forExtension("jpeg"))
        response.setHeader(.contentLength, value: "\(imageBytes.count)")
        response.setBody(bytes: imageBytes)
    } catch {
        response.status = .internalServerError
        response.setBody(string: "Error handling request: \(error)")
    }
    response.completed()
}

do {
    // Launch the HTTP server.
    try HTTPServer.launch(
        .server(name: "www.example.ca", port: 8181, routes: routes))
} catch {
    fatalError("\(error)") // fatal error launching one of the servers
}
