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
        
        routes.add(method: .get, uri: "/user") { request, response in
            
            let user = UserObject(username: "fdsfds", age: 42, isFunToBeAround: true)
            
            guard let encodedData = try? JSONEncoder().encode(user) else {
                response.status = .internalServerError
                print("encoding error")
                return
            }
            response.setBody(bytes: Array(encodedData))
            response.completed()
        }
        
        routes.add(method: .get, uri: "/iamerror") { request, response in
            response.status = .notFound
            response.completed()
        }
        return routes
    }
}
