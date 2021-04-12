//
//  PostsPresenter.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/6/21.
//

import Foundation

protocol CreatePostsPresenterProtocol {
    func showSuccess()
    func showFail()
    func showPosts(res:[CreatePostsResponse])
    func showPostsForUserId(res:CreatePostsResponse)
    func showAllPostsForUserId(res:[CreatePostsResponse])

}

class CreatePostsPresenter: CreatePostsPresenterProtocol{
    
    var viewController: CreatePostsViewControllerProtocol?
    
    init(){}
    
    init(vc: CreatePostsViewControllerProtocol) {
        self.viewController = vc
    }
    
    func showSuccess() {
        viewController?.showMessage(message: "Success")
    }
    
    func showFail() {
        viewController?.showMessage(message: "Failed")
    }
    
    func showPosts(res:[CreatePostsResponse]) {
        viewController?.showPosts(res:res)
    }
    
    func showAllPostsForUserId(res:[CreatePostsResponse]) {
        viewController?.showAllPostsForUserId(res: res)
    }
    
    func showPostsForUserId(res:CreatePostsResponse) {
        viewController?.showPostsForUserId(res:res)
    }
}
