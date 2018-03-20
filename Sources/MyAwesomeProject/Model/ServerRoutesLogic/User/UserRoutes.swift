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
            
            let user = UserObject(username: "tyler", age: 42, isFunToBeAround: true, user: nil)
            
            guard let encodedData = try? JSONEncoder().encode(user) else {
                response.status = .internalServerError
                print("encoding error")
                return
            }
            response.setBody(bytes: Array(encodedData))
            response.completed()
        }
        
        routes.add(method: .get, uri: "/user/test") { request, response in
            
            var returnedArray = Array<UserObject>()
            
            for _ in 1...3 {
                var userArray = Array<User>()
                for _ in 1...3 {
                    userArray.append(User(id: 123456, textID: "textID", nickname: "tyler", avatarTextID: "me.jpg"))
                }
                returnedArray.append(UserObject(username: "tyler", age: 42, isFunToBeAround: true, user: userArray))
            }
            
            guard let encodedData = try? JSONEncoder().encode(returnedArray) else {
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
