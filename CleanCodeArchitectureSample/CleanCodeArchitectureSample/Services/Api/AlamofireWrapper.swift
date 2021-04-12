//
//  AlamofireWrapper.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation
import Alamofire

class AlamoFireNetworkServiceWrapper: NetworkServiceWrapper {
    
    private var interceptor: RequestInterceptor
    
    init(interceptor: RequestInterceptor) {
        self.interceptor = interceptor
        self.interceptor.refreshService = RefreshService(networkService: self)
    }
    
    func performDownload(route: APIRouter, completion: @escaping (String?, Error?) -> Void) {
        
    }
    
    func performRequest<T>(for: T.Type, route: APIRouter, completion: @escaping DictionaryNetworkResponseHandler<T>) where T : Decodable {
        AF.request(route,
                   interceptor: interceptor)
            .responseData { (response) in
                var statusCode = -1
                if let code = response.response?.statusCode {
                    statusCode = code
                }
                switch response.result {
                case .success(let data):
                    do {
                        if let request = route.urlRequest, let url = request.url {
//                            Logger.d("Url: \(url)")
//                            Logger.d(data.prettyPrintedJSONString as String)
                        }
                        //here dataResponse received from a network request
                        let decoder = JSONDecoder()
                        if statusCode == 401 {
                            completion(nil, nil, NSError(domain:"Unauthorized", code: 401))
                        } else {
                            if ( statusCode == 400 ) {
                                var alertResponse : AlertResponse = try decoder.decode(AlertResponse.self, from:data)
                                alertResponse.alertType = AlertType.noResultsFound
                                completion(nil, alertResponse, nil)
                            } else {
                                let dataInfo = try decoder.decode(T.self, from:
                                                                    data)
                                completion(dataInfo, nil, nil)
                            }
                        }
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                        completion(nil, nil, nil)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                        completion(nil, nil, nil)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                        completion(nil, nil, nil)
                    } catch let DecodingError.typeMismatch(type, context) {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                        completion(nil, nil, nil)
                    } catch {
                       // Logger.e(error.localizedDescription)
                        completion(nil, nil, error)
                    }
                case .failure(let error):
                   // Logger.e(error.localizedDescription)
                    if error.localizedDescription.contains("The Internet connection appears to be offline") {
                        var alertResponse = AlertResponse(description: "No Internet connection", code: 1, alertType: .offline)
                        for endPoint in EndPoint.allCases {
                            if route.endPoint.contains(endPoint.rawValue) {
                                alertResponse.endPoint = endPoint
                                break
                            }
                        }
                        completion(nil, alertResponse, nil)
                        
                    } else {
                        if ( statusCode == 200 ) {
                            completion(nil,nil,nil)
                            return
                        }
                        completion(nil, nil, error)
                    }
                }
            }
    }
    
    func performArrayRequest<T>(for: T.Type, route: APIRouter, completion: @escaping ArrayNetworkResponseHandler<T>) where T : Decodable {
        AF.request(route,
                   interceptor: interceptor)
            .responseData { (response) in
                var statusCode = -1
                if let code = response.response?.statusCode {
                    statusCode = code
                }
                switch response.result {
                case .success(let data):
                    do {
                        if let request = route.urlRequest, let url = request.url {
//                            Logger.d("Url: \(url)")
//                            Logger.d(data.prettyPrintedJSONString as String)
                        }
                        //here dataResponse received from a network request
                        let decoder = JSONDecoder()
                        if statusCode == 401 {
                            completion(nil, nil, NSError(domain:"Unauthorized", code: 401))
                        } else {
                            if ( statusCode == 400 ) {
                                var alertResponse : AlertResponse = try decoder.decode(AlertResponse.self, from:data)
                                alertResponse.alertType = AlertType.noResultsFound
                                completion(nil, alertResponse, nil)
                            } else {
                                let dataInfo = try decoder.decode([T].self, from:
                                                                    data)
                                completion(dataInfo, nil, nil)
                            }
                        }
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                        completion(nil, nil, nil)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                        completion(nil, nil, nil)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                        completion(nil, nil, nil)
                    } catch let DecodingError.typeMismatch(type, context) {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                        completion(nil, nil, nil)
                    } catch {
                       // Logger.e(error.localizedDescription)
                        completion(nil, nil, error)
                    }
                case .failure(let error):
                   // Logger.e(error.localizedDescription)
                    if error.localizedDescription.contains("The Internet connection appears to be offline") {
                        var alertResponse = AlertResponse(description: "No Internet connection", code: 1, alertType: .offline)
                        for endPoint in EndPoint.allCases {
                            if route.endPoint.contains(endPoint.rawValue) {
                                alertResponse.endPoint = endPoint
                                break
                            }
                        }
                        completion(nil, alertResponse, nil)
                        
                    } else {
                        if ( statusCode == 200 ) {
                            completion(nil,nil,nil)
                            return
                        }
                        completion(nil, nil, error)
                    }
                }
            }
    }
    
    
    func performDataRequest(route: APIRouter, completion: @escaping (Data?, Error?) -> Void) {
        
    }
}
