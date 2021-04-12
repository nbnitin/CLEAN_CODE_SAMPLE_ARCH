//
//  EndPoints.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation
public enum EndPoint: String, CaseIterable, Codable {
    case allUsers = "users"
    case refresh = "ff"
    case createPosts = "posts"
    case getAllPhotos = "photos"
    
    public var description: String {
        return rawValue
    }
}
