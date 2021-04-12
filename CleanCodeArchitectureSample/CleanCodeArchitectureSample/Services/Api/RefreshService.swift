//
//  RefreshService.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation
protocol RefreshServiceProtocol {
    
    func refresh(completion: @escaping (Login?, Error?) -> Void)
}

class RefreshService: BaseService, RefreshServiceProtocol {
    
    func refresh(completion: @escaping (Login?, Error?) -> Void) {
        self.networkService
            .performRequest(for: Login.self,
                            route: RefreshApiRouter.refresh,
                            completion: { (response, failure, error) in
                                if let login: Login = response {
                                    if let authToken = login.access_token,
                                        let refreshToken = login.refresh_token {
                                        //KeyChainServiceWrapper.standard.authToken = authToken
                                        //KeyChainServiceWrapper.standard.refreshToken = refreshToken
                                        completion(login, nil)
                                    } else {
                                        //KeyChainServiceWrapper.standard.authToken = nil
                                        //KeyChainServiceWrapper.standard.refreshToken = nil
                                        completion(nil, error)
                                    }
                                } else {
//                                    Logger.e(error.debugDescription)
                                }
            })
    }
}
