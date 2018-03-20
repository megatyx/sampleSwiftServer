//
//  UserRoutes.swift
//  MyAwesomeProject
//
//  Created by Tyler Wells on 3/20/18.
//

import Foundation
import PerfectHTTP
import PerfectHTTPServer
import PerfectLib

extension ServerRoutes {
    
    func addUserRoutes() -> Routes {
        var routes = Routes()
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
        
        return routes
    }
    
}
