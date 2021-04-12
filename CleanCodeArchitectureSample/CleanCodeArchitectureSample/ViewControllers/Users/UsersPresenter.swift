//
//  UsersPresenter.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

//this is the presenter file, this will only handle display logic

import Foundation

protocol UserPresenterProtocol{
    func showAllUsers(res:[AllUsers]?)
}

class UserPresenter: UserPresenterProtocol {
    
    var vc : ViewControllerDisplayLogicProtocol?
    
    
    init(){}
    
    init(vc:ViewControllerDisplayLogicProtocol){
        self.vc = vc
    }
    
    func showAllUsers(res: [AllUsers]?) {
        vc?.displayAllUsers(res: res)
    }
}
