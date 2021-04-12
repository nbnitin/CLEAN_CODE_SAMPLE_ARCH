//
//  DataProvider.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation

protocol DataProviderProtocol {
    var userService: UserServiceProtocol { get }
    var refreshService: RefreshServiceProtocol { get }
    var postService: PostsServiceProtocol { get }
    var imageService : ImageServiceProtocol { get }
    var getAllPhotos : PhotoServiceProtocol { get }
}

class ApiStore: DataProviderProtocol {
     
    static let instance = ApiStore()
    private var networkService: NetworkServiceWrapper
    private var networkImageService: NetworkImageServiceWrapper
    private var interceptor: RequestInterceptor
    
    private init() {
        self.interceptor = RequestInterceptor(
            storage: StorageServiceWrapper.standard)
        self.networkService = AlamoFireNetworkServiceWrapper(interceptor: interceptor)
        self.networkImageService = AlamoFireImageDownloadService()
    }
    
    var refreshService: RefreshServiceProtocol {
        return RefreshService(networkService: networkService)
    }
    
    var userService: UserServiceProtocol {
        return UserService(networkService: networkService)
    }
    
    var postService: PostsServiceProtocol{
        return PostsService(networkService: networkService)
    }
    
    var imageService: ImageServiceProtocol {
        return ImageService(networkImageService: self.networkImageService)
    }
    
    var getAllPhotos: PhotoServiceProtocol{
        return PhotoService(networkService: self.networkService)
    }
}
