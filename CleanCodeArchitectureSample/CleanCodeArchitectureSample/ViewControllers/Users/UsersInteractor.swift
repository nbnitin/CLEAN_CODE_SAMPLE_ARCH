//
//  UsersInteractor.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

//this is the interactor file, this is being interacted by vc and this will further interacts with presenter. The interactor file usually has the code to interacts with server api like stuff

import Foundation

protocol UserInteractorProtocol{
    func getAllUsers()
}

class UserInteractor:UserInteractorProtocol {
    
    let worker : UserWorker = UserWorker(dataStore: ApiStore.instance)
    var presenter : UserPresenterProtocol?
    
    init(){}
    
    //MARK: get all users
    func getAllUsers() {
        worker.getAllUsers(completion: {res,alert,err in
            self.presenter?.showAllUsers(res: res)
        })
    }
}
