//
//  Constants.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation

enum DefaultImages:String {
    case defaultImage = "user_place_holder"
}


struct APIParameterKey {
    static let contentType = "contentType"
    static let filter = "filter"
    static let page = "page"
    static let size = "size"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case clusterUrl = "CLUSTER_URL"
}

enum ContentType: String {
    case json = "application/json"
}
