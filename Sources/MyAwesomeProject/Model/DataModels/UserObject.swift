//
//  UserObject.swift
//  MyAwesomeProjectPackageDescription
//
//  Created by Tyler Wells on 3/19/18.
//

import Foundation

struct UserObject: Codable {
    
    let username: String
    let age: Int
    let isFunToBeAround: Bool
    let user: [User]?
    
}
