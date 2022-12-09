//
//  MessageModel.swift
//  Chateamos
//
//  Created by Kirk Abbott on 12/8/22.
//

import Foundation

struct message : Decodable{
    var UID : String
    var body : String
    var timestamp : String
    var username : String
    
}

struct user {
    var UID : String
    var email : String
    var password : String
    var username : String
    
}
