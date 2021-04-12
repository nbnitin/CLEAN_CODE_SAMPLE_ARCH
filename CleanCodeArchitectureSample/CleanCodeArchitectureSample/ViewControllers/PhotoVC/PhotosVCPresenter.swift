//
//  PhotosVCPresenter.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/8/21.
//

import Foundation

protocol PhotoVCPresenterProtocol {
    func showPhotos(res: [GetAllPhotosResponse])
}

class PhotoVCPresenter: PhotoVCPresenterProtocol {
    var viewControler : PhotosViewControllerDisplayProtocol?
    
    init(){}
    
    init(vc: PhotosViewControllerDisplayProtocol?) {
        self.viewControler = vc
    }
    
    func showPhotos(res: [GetAllPhotosResponse]) {
        viewControler?.showPhotos(res:res)
    }
}
