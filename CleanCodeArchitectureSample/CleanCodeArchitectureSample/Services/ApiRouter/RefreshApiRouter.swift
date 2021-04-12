//
//  RefreshService.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation
import Alamofire

enum RefreshApiRouter: APIRouter {
    
    case refresh
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .refresh:
            return .get
        }
    }
    // MARK: - Path
    var endPoint: String {
        switch self {
        case.refresh:
            return EndPoint.refresh.rawValue
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .refresh:
            return nil
        }
    }
}
