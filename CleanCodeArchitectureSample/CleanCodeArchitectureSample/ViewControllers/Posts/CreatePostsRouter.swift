//
//  PostsRouter.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/6/21.
//

import Foundation

protocol CreatePostsRouterProtocol{
    func goBackToParent()
}

protocol CreatePostsDataPassing {
    var dataStore:CreatePostsDataStore? {get set}
}

class CreatePostsRouter: CreatePostsDataPassing,CreatePostsRouterProtocol {
    
    var dataStore: CreatePostsDataStore?
    weak var vc : CreatePostsViewController?
    
    func goBackToParent() {
        
    }
    
}
