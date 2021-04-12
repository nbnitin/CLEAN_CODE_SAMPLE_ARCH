//
//  FileApiRouter.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/12/21.
//

import Foundation
import Alamofire

enum FileApiRouter: APIRouter {
    
   // case uploadFile(request: UploadRequest)
    case downloadFile(url: String)
    
    var baseUrl: String {
        switch self {
        case .downloadFile(let url):
            return url
//        case .uploadFile:
//            return Environment.backendUrl
        }
    }
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .downloadFile:
            return .get
//        case .uploadFile:
//            return .post
        }
    }
    // MARK: - Path
    var endPoint: String {
        switch self {
        case.downloadFile:
            return ""
//        case .uploadFile:
//            return EndPoint.upload.rawValue
//
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .downloadFile:
            return nil
//        case .uploadFile:
//            return nil
        }
    }
}
