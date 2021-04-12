//
//  UsersModel.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation
struct AllUsers: Codable {
    let id: Int?
    let name: String?
    var username: String?
    var email: String?
    var address: Address?
    var geo: Geo?
    var phone: String?
    var website: String?
    var company: Company?
}

struct Company: Codable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}

struct Geo: Codable{
    let lat: String?
    let lng: String?
}

struct Address: Codable{
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
}


