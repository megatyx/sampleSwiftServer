//
//  User.swift
//  Domain
//
//  Created by Ray on 2018/3/6.
//  Copyright © 2018年 italki. All rights reserved.
//

import Foundation

public struct User: Codable {
    
    public let id: Int
    public let textID: String
    public let nickname: String
    public let avatarTextID: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case textID = "textid"
        case nickname
        case avatarTextID = "avatar_file_name"
    }
    
    public init(id: Int, textID: String, nickname: String, avatarTextID: String) {
        self.id = id
        self.textID = textID
        self.nickname = nickname
        self.avatarTextID = avatarTextID
    }
    
}
