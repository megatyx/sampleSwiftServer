//
//  ServerRoutes.swift
//  MyAwesomeProject
//
//  Created by Tyler Wells on 3/20/18.
//

import Foundation
import PerfectHTTP
import PerfectHTTPServer
import PerfectLib

struct ServerRoutes {
    
     func buildRoutes() -> Routes {
        // Register your own routes and handlers
        var routes = Routes()
        routes.add(method: .get, uri: "/") { request, response in
            response.setHeader(.contentType, value: "text/html")
            response.appendBody(string: "<html><title>sampleSwiftServer</title><body>API Root</body></html>")
            response.completed()
        }
        
        routes.add(method: .get, uri: "/hello") { request, response in
            if let name = request.param(name: "name"), name == "tyler" {
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
            } else {
                response.setHeader(.contentType, value: "text/html")
                response.appendBody(string: "<html><title>sampleSwiftServer</title><body>Hello, world!</body></html>")
            }
            response.completed()
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
        
        routes.add(ServerRoutes().addUserRoutes())
        
        routes.add(method: .get, uri: "/iamerror") { request, response in
            response.status = .notFound
            response.completed()
        }
        
        routes.add(method: .get, uri: "/check") { request, response in
            print("going into API check")
            
            APISession.check(success: {
                response.setHeader(.contentType, value: "text/html")
                response.appendBody(string: "<html><title>sldkfja;lksdjf</title><body>API</body></html>")
                response.completed()
            })
        }
        
        routes.add(method: .get, uri: "/login") { request, response in
            APISession.login(email: "tyler@test.com", password:"abc123@", success: {
                response.setHeader(.contentType, value: "text/html")
                response.appendBody(string: "<html><title>sampleSwiftServer</title><body>API Root</body></html>")
                response.completed()
            })
        }
        return routes
    }
}
