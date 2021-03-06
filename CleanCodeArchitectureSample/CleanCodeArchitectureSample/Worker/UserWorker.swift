//
//  UserWorker.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation

class UserWorker: Worker {
    func getAllUsers(completion: @escaping GetAllUsersResponseHandler<AllUsers>){
        dataStore.userService.getAllUsers(completion: { res,alert,err in
            completion(res,alert,err)
        })
    }
    
    func downloadFile(url:String,completion: @escaping (String?,Error?)->Void ) {
        dataStore.userService.downloadFile(url: FileApiRouter.downloadFile(url: url), completion: {(path,err) in
            completion(path,err)
        })
    }
}
