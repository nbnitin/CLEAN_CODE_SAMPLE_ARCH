//
//  AlamofireDownloadImageService.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/8/21.
//

import Foundation
import AlamofireImage

class AlamoFireImageDownloadService: NetworkImageServiceWrapper {
    
    let imageCache: AutoPurgingImageCache
    let imageDownloader: ImageDownloader
    
    init() {
        //adding custom mime type to alamofire
        ImageResponseSerializer.addAcceptableImageContentTypes(["image/jpg"])

       imageCache = AutoPurgingImageCache(
            memoryCapacity: UInt64(100).megabytes(),
            preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
        )
        
        imageDownloader = ImageDownloader(
            configuration: ImageDownloader.defaultURLSessionConfiguration(),
            downloadPrioritization: .fifo,
            maximumActiveDownloads: 4,
            imageCache: imageCache
        )
    }
    
    func downloadImage(url: String,
                       completion: @escaping (UIImage?, Error?) -> Void) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        imageDownloader.download(urlRequest) { response in
            switch response.result {
            case .success(let image):
                completion(image, nil)
                
            case .failure(let error):
                //Logger.e(error.localizedDescription)
                completion(nil, error)
                
            }
        }
    }
}
