//
//  Login.swift
//  MobiTalksTDDiOS
//
//  Created by Victor Magalhaes on future.
//  Copyright © 2018 MobiTalks. All rights reserved.
//

struct Login: Codable {
    var user: String
    var pass: String
    
    enum CodingKeys: String, CodingKey {
        case user = "user"
        case pass = "pass"
    }
    
    func toDict() -> [String: String] {
        return [
            "user": user,
            "pass": pass
        ]
    }
}

struct LoginSuccess: Codable {
    var codigo: String?
    var nome: String?
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case codigo
        case nome
        case email
    }
}

