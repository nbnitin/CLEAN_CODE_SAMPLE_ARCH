//
//  CreatePostsResponse.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/6/21.
//

import Foundation

struct CreatePostsResponse: Codable {
    let title:String?
    let body:String?
    let userId:Int?
    let id:Int?
}
