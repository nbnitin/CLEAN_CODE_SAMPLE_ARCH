//
//  ApiBaseService.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation
class BaseService {
    
    var networkService: NetworkServiceWrapper
    
    init(networkService: NetworkServiceWrapper) {
        self.networkService = networkService
    }
}

class BaseImageService {
    
    var networkImageService: NetworkImageServiceWrapper
    
    init(networkImageService: NetworkImageServiceWrapper) {
        self.networkImageService = networkImageService
    }
}
