//
//  NetworkWrapper.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatiaon 4/5/21.
//

import Foundation
import Alamofire

protocol NetworkServiceWrapper {
    
    func performDataRequest(route: APIRouter,
                            completion: @escaping (Data?, Error?) -> Void)
    
    func performArrayRequest<T: Decodable>(for: T.Type,
                                      route: APIRouter,
                                      completion: @escaping ArrayNetworkResponseHandler<T>)
    
    
    func performRequest<T: Decodable>(for: T.Type,
                                      route: APIRouter,
                                      completion: @escaping DictionaryNetworkResponseHandler<T>)
    
    func performDownload(route: APIRouter,
                         completion: @escaping (String?, Error?) -> Void)
    
//    func performUpload<T: Decodable>(for: T.Type,
//                                     route: APIRouter,
//                                     params: Dictionary<String, Any>,
//                                     completion: @escaping UploadNetworkResponseHandler<T>)
//    func performUpload<T: Decodable>(for: T.Type,
//                                        route: APIRouter,
//                                        params: Dictionary<String, Any>,
//                                        uploadProgress: @escaping UploadProgressResponse,
//                                        completion: @escaping UploadNetworkResponseHandler<T>)
}

protocol NetworkImageServiceWrapper {
    func downloadImage(url: String,
                       completion: @escaping (UIImage?, Error?) -> Void)
}
