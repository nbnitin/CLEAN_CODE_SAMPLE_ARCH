//
//  GetAllPhotosWorker.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/9/21.
//

import Foundation

class GetAllPhotosWorker:Worker{
    func getPhotos(completionHandler: @escaping ArrayNetworkResponseHandler<GetAllPhotosResponse>){
        dataStore.getAllPhotos.getPhotos(completion: {(res,alert,err) in
            completionHandler(res,alert,err)
        })
    }
}
