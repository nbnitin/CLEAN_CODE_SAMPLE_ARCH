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
    
    func performDownload(route: APIRouter,
                         completion: @escaping (String?, Error?) -> Void) {
        
        AF.session.configuration.timeoutIntervalForRequest = 180
        var downloadedFilePath: String?
        
        let destination: DownloadRequest.Destination = { temporaryURL, response in
            if let suggestedFileName = response.suggestedFilename {
                do {
                    let directory = try Utils.tempDirectory()
                    downloadedFilePath = (directory + "/" + suggestedFileName)
                    if let downloadedFilePath = downloadedFilePath {
                        if Utils.fileExists(at: downloadedFilePath) {
                            let res = try Utils.deleteFile(at: downloadedFilePath)
                            print("File deleted with path nad result : \(res)")
                        }
                        return (URL(fileURLWithPath: downloadedFilePath),
                                [.removePreviousFile]) //.createIntermediateDirectories
                    }
                } catch let e {
                   print("Failed to get temporary directory - \(e)")
                }
            }
            
            let (downloadedFileURL, _) = DownloadRequest
                .suggestedDownloadDestination()(temporaryURL, response)
            downloadedFilePath = downloadedFileURL.absoluteString
            return (downloadedFileURL, [.removePreviousFile])//, .createIntermediateDirectories
        }
        
        AF.download(route, to: destination)
            .response { defaultDownloadResponse in
                print(defaultDownloadResponse.result)
                
                let result = defaultDownloadResponse.result
                switch result {
                case .success(let value):
                    if let request = route.urlRequest, let url = request.url {
//                        Logger.d("Url: \(url)")
//                        Logger.d(value.debugDescription)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
                guard let downloadedFilePath = downloadedFilePath else { return }
                completion(downloadedFilePath, nil)
        }
    }
    
//    func performUpload<T: Decodable>(for: T.Type = T.self,
//                                     route: APIRouter,
//                                     params: Dictionary<String, Any>,
//                                     completion: @escaping UploadNetworkResponseHandler<T>) {
//
//        let result =
//            AF.upload(multipartFormData: { (multiFormData) in
//                for (key, value) in params {
//                    if let data = value as? Data {
//                        multiFormData.append(data, withName: key)
//                    } else if let tupleData = value as? TupleVariable {
//                        multiFormData.append(tupleData.0,
//                                             withName: key,
//                                             fileName: tupleData.1,
//                                             mimeType: tupleData.2)
//
//                    }
//                }
//            }, with: route,
//               interceptor: interceptor)
//                .responseData { (response) in
//                    var statusCode = 1
//                    if let code = response.response?.statusCode {
//                        statusCode = code
//                    }
//
//                    let alertResponse = AlertResponse(description:AlertMessages.share_failure.desc, code: AlertMessages.share_failure.rawValue, alertType: .share_failure)
//                    let result = response.result
//                    switch result {
//                    case .success(let data):
//                        do {
//                            if let request = route.urlRequest, let url = request.url {
//                                Logger.d("Url: \(url)")
//                                Logger.d(data.prettyPrintedJSONString as String)
//                            }
//                            //here dataResponse received from a network request
//                            let decoder = JSONDecoder()
//                            if statusCode == 200 {
//                                let dataInfo = try decoder.decode(T.self, from:
//                                    data)
//                                completion(dataInfo, nil, nil)
//                            } else {
//                                completion(nil, alertResponse, nil)
//                            }
//
//                        } catch let DecodingError.dataCorrupted(context) {
//                            print(context)
//                            completion(nil, alertResponse, nil)
//                        } catch let DecodingError.keyNotFound(key, context) {
//                            print("Key '\(key)' not found:", context.debugDescription)
//                            print("codingPath:", context.codingPath)
//                            completion(nil, alertResponse, nil)
//                        } catch let DecodingError.valueNotFound(value, context) {
//                            print("Value '\(value)' not found:", context.debugDescription)
//                            print("codingPath:", context.codingPath)
//                            completion(nil, alertResponse, nil)
//                        } catch let DecodingError.typeMismatch(type, context) {
//                            print("Type '\(type)' mismatch:", context.debugDescription)
//                            print("codingPath:", context.codingPath)
//                            completion(nil, alertResponse, nil)
//                        } catch {
//                            Logger.e(error.localizedDescription)
//                            completion(nil, alertResponse, error)
//                        }
//                    case .failure(let error):
//                        if error.localizedDescription.contains("The Internet connection appears to be offline") {
//                           var alertResponse = AlertResponse(description: AlertMessages.no_connection.desc, code: AlertMessages.no_connection.rawValue, alertType: .offline)
//                            for endPoint in EndPoint.allCases {
//                                if route.endPoint.contains(endPoint.rawValue) {
//                                    alertResponse.endPoint = endPoint
//                                }
//                            }
//                            completion(nil, alertResponse, nil)
//
//                        } else {
//                            completion(nil, nil, error)
//                        }
//                    }
//                    Logger.d(response.debugDescription)
//        }
//        Logger.d("printing result \(result.description)")
//    }
//
//    func performUpload<T>(for: T.Type, route: APIRouter, params: Dictionary<String, Any>, uploadProgress: @escaping UploadProgressResponse, completion: @escaping (T?, AlertResponse?, Error?) -> Void) where T : Decodable {
//        let result =
//            AF.upload(multipartFormData: { (multiFormData) in
//                for (key, value) in params {
//                    if let data = value as? Data {
//                        multiFormData.append(data, withName: key)
//                    } else if let tupleData = value as? TupleVariable {
//                        multiFormData.append(tupleData.0,
//                                             withName: key,
//                                             fileName: tupleData.1,
//                                             mimeType: tupleData.2)
//
//                    }
//                }
//            }, with: route,
//               interceptor: interceptor)
//                .uploadProgress(queue: .main, closure: { (progress) in
//                    uploadProgress(progress)
//                    debugPrint("Unique \(progress.description)")
//                })
//                .responseData { (response) in
//                    var statusCode = 1
//                    if let code = response.response?.statusCode {
//                        statusCode = code
//                    }
//
//                    let alertResponse = AlertResponse(description:AlertMessages.share_failure.desc, code: AlertMessages.share_failure.rawValue, alertType: .share_failure)
//                    let result = response.result
//                    switch result {
//                    case .success(let data):
//                        do {
//                            if let request = route.urlRequest, let url = request.url {
//                                Logger.d("Url: \(url)")
//                                Logger.d(data.prettyPrintedJSONString as String)
//                            }
//                            //here dataResponse received from a network request
//                            let decoder = JSONDecoder()
//                            if statusCode == 200 {
//                                let dataInfo = try decoder.decode(T.self, from:
//                                    data)
//                                completion(dataInfo, nil, nil)
//                            } else {
//                                completion(nil, alertResponse, nil)
//                            }
//
//                        } catch let DecodingError.dataCorrupted(context) {
//                            print(context)
//                            completion(nil, alertResponse, nil)
//                        } catch let DecodingError.keyNotFound(key, context) {
//                            print("Key '\(key)' not found:", context.debugDescription)
//                            print("codingPath:", context.codingPath)
//                            completion(nil, alertResponse, nil)
//                        } catch let DecodingError.valueNotFound(value, context) {
//                            print("Value '\(value)' not found:", context.debugDescription)
//                            print("codingPath:", context.codingPath)
//                            completion(nil, alertResponse, nil)
//                        } catch let DecodingError.typeMismatch(type, context) {
//                            print("Type '\(type)' mismatch:", context.debugDescription)
//                            print("codingPath:", context.codingPath)
//                            completion(nil, alertResponse, nil)
//                        } catch {
//                            Logger.e(error.localizedDescription)
//                            completion(nil, alertResponse, error)
//                        }
//                    case .failure(let error):
//                        if error.localizedDescription.contains("The Internet connection appears to be offline") {
//                            var alertResponse = AlertResponse(description: AlertMessages.no_connection.desc, code: AlertMessages.no_connection.rawValue, alertType: .offline)
//                            for endPoint in EndPoint.allCases {
//                                if route.endPoint.contains(endPoint.rawValue) {
//                                    alertResponse.endPoint = endPoint
//                                }
//                            }
//                            completion(nil, alertResponse, nil)
//
//                        } else {
//                            completion(nil, nil, error)
//                        }
//                    }
//                    Logger.d(response.debugDescription)
//        }
//        Logger.d("printing result \(result.description)")
//
//    }
    
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
