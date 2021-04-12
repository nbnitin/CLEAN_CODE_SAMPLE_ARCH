//
//  PhotosService.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/8/21.
//

import Foundation

protocol PhotoServiceProtocol {
    func getPhotos(completion: @escaping ArrayNetworkResponseHandler<GetAllPhotosResponse>)
}

class PhotoService: BaseService,PhotoServiceProtocol {
    func getPhotos(completion: @escaping ArrayNetworkResponseHandler<GetAllPhotosResponse>) {
        self.networkService.performArrayRequest(for: GetAllPhotosResponse.self, route: GetAllPhotosApiRouter.getPhotos, completion: {(res,alert,err) in
            completion(res,alert,err)
        })
    }
}
