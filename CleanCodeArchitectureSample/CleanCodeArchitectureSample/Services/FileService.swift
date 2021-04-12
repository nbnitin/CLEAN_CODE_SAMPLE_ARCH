//
//  FileService.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/12/21.
//

import Foundation

protocol FileServiceProtocol {
    
    func downloadFile(with url: String, completion: @escaping (String?, Error?) -> Void)
//    func upload(uploadRequest: UploadRequest, completion: @escaping (UploadResponse?, Error?) -> Void)
//    func upload(shareUploadRequest: ShareUploadRequest, uploadProgress: @escaping UploadProgressResponse, completion: @escaping UploadResponseHandler)
}

class FileService: BaseService, FileServiceProtocol {
    
    func downloadFile(with url: String, completion: @escaping (String?, Error?) -> Void) {
        self.networkService
            .performDownload(route: FileApiRouter.downloadFile(url: url)) { (destinationFilePath, error) in
                if error == nil {
                    completion(destinationFilePath, error)
                } else {
                    completion(nil, error)
                }
        }
    }
    
//    func upload(uploadRequest: UploadRequest,
//                completion: @escaping (UploadResponse?, Error?) -> Void) {
//        let multipartParams = uploadRequest.multipartParams()
//        self.networkService.performUpload(
//            for: UploadResponse.self,
//            route: FileApiRouter.uploadFile(request: uploadRequest),
//            params: multipartParams) { (uploadResponse, failure, error) in
//                completion(uploadResponse, error)
//        }
//    }
//    
//    func upload(shareUploadRequest: ShareUploadRequest, uploadProgress: @escaping UploadProgressResponse, completion: @escaping UploadResponseHandler) {
//        let multipartParams = shareUploadRequest.multipartParams()
//        self.networkService.performUpload(for: UploadResponse.self, route: FileApiRouter.share(request: shareUploadRequest), params: multipartParams, uploadProgress: { (progress) in
//            uploadProgress(progress)
//        }) { (uploadResponse, failure, error) in
//            completion(uploadResponse, failure, error)
//        }
//    }
}
