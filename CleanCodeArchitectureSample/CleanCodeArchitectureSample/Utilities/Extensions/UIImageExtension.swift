//
//  UIImageExtension.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/8/21.
//

import UIKit
import Alamofire
import AlamofireImage

class ImageCache {

    let imageCache = AutoPurgingImageCache(
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )
    
    // MARK: - Image Caching

    func cache(_ image: UIImage, for url: String) {
        imageCache.add(image, withIdentifier: url)
    }

    func cachedImage(for url: String) -> UIImage? {
        return imageCache.image(withIdentifier: url)
    }
}

let imageCache = ImageCache()
extension UIImageView {
    func loadImageUsingUrlString(urlString: String, spinner: UIActivityIndicatorView?) {
        loadImageUsingUrlString(urlString: urlString, spinner: spinner, defaultImageName: DefaultImages.defaultImage.rawValue)
    }
    
    func loadImageUsingUrlString(urlString: String, spinner: UIActivityIndicatorView?, defaultImageName: String) {
        spinner?.startAnimating()
        spinner?.isHidden = false
        
        guard let url = URL(string: urlString) else {
            spinner?.stopAnimating()
            spinner?.isHidden = true
            self.image = UIImage(named: defaultImageName)
            return
        }
        
        image = nil
        
        if let imageFromCache = imageCache.cachedImage(for: urlString) {
            self.image = imageFromCache
            spinner?.stopAnimating()
            spinner?.isHidden = true
            return
        }
        
        let imageService: ImageServiceProtocol = ApiStore.instance.imageService
        imageService.fetchImage(with: urlString) { (image, error) in
            if error == nil {
                guard let imageToCache = image else {
                    spinner?.stopAnimating()
                    spinner?.isHidden = true
                    return
                }
                DispatchQueue.main.async {
                   // if self.imageUrlString == urlString {
                        self.image = imageToCache
                        spinner?.stopAnimating()
                        spinner?.isHidden = true
                   // }
                    imageCache.cache(imageToCache, for: urlString)
                }
            } else {
                DispatchQueue.main.async {
                    spinner?.stopAnimating()
                    spinner?.isHidden = true
                    self.image = UIImage(named: defaultImageName)
                    //                    Logger.e("Error occurred while loading image from url \(url) error description is \(error?.localizedDescription ?? "")")
                }
            }
        }
    }
}


