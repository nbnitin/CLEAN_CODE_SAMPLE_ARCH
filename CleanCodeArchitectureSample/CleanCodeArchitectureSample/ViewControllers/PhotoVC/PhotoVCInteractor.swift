//
//  PhotoVCInteractor.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/8/21.
//

import Foundation
protocol PhotoVCInteractorProtocol{
    func getAllPhotos()
}

class PhotoVCInteractor: PhotoVCInteractorProtocol {
    
    var presenter : PhotoVCPresenterProtocol?
    let worker : GetAllPhotosWorker = GetAllPhotosWorker(dataStore: ApiStore.instance)
    
    func getAllPhotos() {
        worker.getPhotos(completionHandler: {(res,alert,err) in
            if res != nil {
                self.presenter?.showPhotos(res: res!)
            }
        })
    }
    
}
