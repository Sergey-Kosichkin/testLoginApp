//
//  Person.swift
//  testLoginApp
//
//  Created by Сергей Косичкин on 04.04.2021.
//

struct Person {
  static func get(_ data: Info) -> String {
        var info = ""
        
        switch data {
        case .name:
            info = "Ivan"
        case .surname:
            info = "Ivanov"
        case .skill:
            info = "5"
        case .age:
            info = "25"
        }
        return info
    }
}

enum Info {
    case name
    case surname
    case skill
    case age
}




