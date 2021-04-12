//
//  UserRouter.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation
import Alamofire

enum UserApiRouter: APIRouter {
    case getAllUsers
   
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getAllUsers:
            return .get
        }
    }
    
    // MARK: - Path
    var endPoint: String {
        switch self {
        case .getAllUsers:
            return EndPoint.allUsers.rawValue
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getAllUsers:
            return nil
        }
    }
}
