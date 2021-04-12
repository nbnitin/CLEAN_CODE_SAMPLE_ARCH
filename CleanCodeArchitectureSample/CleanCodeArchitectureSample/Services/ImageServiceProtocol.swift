//
//  ImageServiceProtocol.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/8/21.
//

import UIKit

protocol ImageServiceProtocol {
    
    func fetchImage(with url: String, completion: @escaping (UIImage?, Error?) -> Void)
}

class ImageService: BaseImageService, ImageServiceProtocol {
    
    func fetchImage(with url: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        self.networkImageService.downloadImage(url: url) { (image, error) in
            if error == nil {
                completion(image, error)
            } else {
                print(error!.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
