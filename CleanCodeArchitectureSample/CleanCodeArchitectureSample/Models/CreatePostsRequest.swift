//
//  CreatePostsRequest.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/6/21.
//

import Foundation

struct CreatePostsRequest:Codable{
    let title: String?
    let body: String?
    let userId: Int?
}
