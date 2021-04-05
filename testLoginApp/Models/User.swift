//
//  LogIn.swift
//  testLoginApp
//
//  Created by Сергей Косичкин on 04.04.2021.
//

struct User {
    static func get(_ data: Data) -> String {
        var info = ""
        
        switch data {
        case .name:
            info = "1"
        case .password:
            info = "1"
        }
        return info
    }
}

enum Data {
    case name
    case password
}

