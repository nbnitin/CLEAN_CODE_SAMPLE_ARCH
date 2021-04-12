//
//  GetAllPhotosRouter.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/8/21.
//

import Foundation
import Alamofire

enum GetAllPhotosApiRouter: APIRouter {
    case getPhotos
   
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getPhotos:
            return .get
        }
    }
    
    // MARK: - Path
    var endPoint: String {
        switch self {
        case .getPhotos:
            return EndPoint.getAllPhotos.rawValue
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getPhotos:
            return nil
        }
    }
}
