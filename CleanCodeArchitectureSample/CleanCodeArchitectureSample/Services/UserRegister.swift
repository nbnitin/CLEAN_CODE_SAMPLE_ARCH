//
//  UserRegister.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation

protocol UserServiceProtocol {
    
    func getAllUsers(completion: @escaping GetAllUsersResponseHandler<AllUsers>)
    func downloadFile(url:FileApiRouter,completion: @escaping (String?,Error?)->Void)
    
}

class UserService: BaseService, UserServiceProtocol {
    
    func getAllUsers(completion: @escaping GetAllUsersResponseHandler<AllUsers>){
        self.networkService.performArrayRequest(for: AllUsers.self, route: UserApiRouter.getAllUsers, completion: {res,alert,err in
            completion(res,alert,err)
        })
       
    }
    
    func downloadFile(url: FileApiRouter, completion: @escaping (String?, Error?)->Void) {
        self.networkService.performDownload(route: url, completion: {(path,error) in
            completion(path,error)
        })
    }
}
