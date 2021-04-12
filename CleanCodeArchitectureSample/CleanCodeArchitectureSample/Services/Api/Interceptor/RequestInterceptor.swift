//
//  RequestInterceptor.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation
import Alamofire

let UN_AUTHORIZED_STATUS_CODE = [401,403]

final class RequestInterceptor: Alamofire.RequestInterceptor {
    
    private let storage: StorageServiceWrapperProtocol
    var refreshService: RefreshServiceProtocol?
    
    init(storage: StorageServiceWrapper) {
        self.storage = storage
    }
    
    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        let absoluteUrlString: String? = urlRequest.url?.absoluteString
        
        
        if  absoluteUrlString?.hasPrefix(Environment.backendUrl + EndPoint.allUsers.rawValue) == true   {
            return completion(.success(urlRequest))
        }
        
        //uncomment for logout
//        if absoluteUrlString?.hasPrefix(Environment.backendUrl + EndPoint.logout.rawValue) == true {
//            var urlRequest = urlRequest
//            urlRequest.setValue(storage.authToken ?? "", forHTTPHeaderField: "Authorization")
//            urlRequest.setValue(storage.refreshToken ?? "", forHTTPHeaderField: "Refresh-Token")
//            completion(.success(urlRequest))
//            return
//        }
        
        if absoluteUrlString?.hasPrefix(Environment.backendUrl + EndPoint.refresh.rawValue) == true {
            var urlRequest = urlRequest
            urlRequest.setValue(storage.refreshToken ?? "", forHTTPHeaderField: "Authorization")
            return completion(.success(urlRequest))
        }
        
        guard self.isAuthorizationNeeded(urlRequest: urlRequest) else {
            return completion(.success(urlRequest))
        }
        var urlRequest = urlRequest
        urlRequest.setValue(storage.authToken ?? "", forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, UN_AUTHORIZED_STATUS_CODE.contains(response.statusCode) else {
            return completion(.doNotRetryWithError(error))
        }
        
        if ( response.statusCode == 403 ) {
            
            let error = NSError(domain: "UnAuthorised", code: 403, userInfo: nil)
            completion(.doNotRetryWithError(error))
            DispatchQueue.main.async {
                //usage time should not be cleared while locking or logging out from the app
//                if self.storage.refreshToken != "" {
//                    UserDefaults.standard.removeObject(forKey: K.APP_LAST_USAGE_TIME_SECONDS)
//                }
                
            }
            return
        }
        
        self.refreshService?.refresh { (_, error) in
            if error == nil {
                completion(.retry)
            } else {
                completion(.doNotRetryWithError(error!))
                DispatchQueue.main.async {
//                    GalleryHomeRouter().routeToLoginVC()
                }
            }
        }
    }
}

extension RequestInterceptor {
    
    func isAuthorizationNeeded(urlRequest: URLRequest) -> Bool {
        let absoluteUrlString: String? = urlRequest.url?.absoluteString
        return (
                absoluteUrlString?.hasPrefix(Environment.backendUrl) == true
                || absoluteUrlString?.hasPrefix(Environment.imageInspectUrl) == true
                || absoluteUrlString?.hasPrefix(Environment.imageInspectImageUrl) == true
                || absoluteUrlString?.hasPrefix(Environment.imageInspectLabelInfoUrl) == true
        )
    }
}
