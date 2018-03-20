import PerfectHTTP
import PerfectHTTPServer

do {
    // Launch the HTTP server.
    try HTTPServer.launch(
        .server(name: "www.example.ca", port: 8181, routes: ServerRoutes().buildRoutes()))
} catch {
    fatalError("\(error)") // fatal error launching one of the servers
}
