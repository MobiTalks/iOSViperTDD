//
//  Login.swift
//  MobiTalksTDDiOS
//
//  Created by Victor Magalhaes on future.
//  Copyright © 2018 MobiTalks. All rights reserved.
//

struct Login: Codable {
    var email: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case password = "password"
    }
    
    func toDict() -> [String: String] {
        return [
            "email": email,
            "password": password
        ]
    }
}

struct LoginSuccess: Codable {
    var token: String?
    
    enum CodingKeys: String, CodingKey {
        case token
    }
}

