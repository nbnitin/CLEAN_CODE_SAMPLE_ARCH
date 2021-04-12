//
//  ApiRouter.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible {
    
    var method: HTTPMethod { get }
    var endPoint: String { get }
    var parameters: Parameters? { get }
    var baseUrl: String { get }
}

extension APIRouter {
    
    var baseUrl: String {
        return Environment.backendUrl
    }
    
    func asURLRequest() throws -> URLRequest {
        let fullURLString = self.baseUrl + endPoint
        let url = try fullURLString.asURL()
        
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
//        let authToken = KeyChainServiceWrapper.standard.authToken
//        let bearerToken: String = (authToken ?? "")
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue,
                            forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue,
                            forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(Environment.backendUrl,
                                   forHTTPHeaderField: HTTPHeaderField.clusterUrl.rawValue)
//        if !fullURLString.contains("login") && !(bearerToken).isEmpty {
//            urlRequest.setValue(bearerToken, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
//        }
        
        // Parameters
        if let parameters = parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
                urlRequest.httpBody = data
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        print("Request : ", urlRequest.description)
        return urlRequest
    }
}
