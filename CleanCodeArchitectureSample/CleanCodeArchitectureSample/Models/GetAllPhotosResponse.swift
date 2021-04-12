//
//  GetAllPhotosResponse.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/8/21.
//

import Foundation
struct GetAllPhotosResponse:Codable {
    let albumId : Int?
    let id : Int?
    let title : String?
    let url : String?
    let thumbnailUrl : String?
}
