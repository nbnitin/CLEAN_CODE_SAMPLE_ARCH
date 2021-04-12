//
//  PostsInteractor.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/6/21.
//

import Foundation

protocol CreatePostsInteractorProtocol{
    func createPost(title:String,body:String)
    func getPosts()
    func getPostsForUserId()
}

protocol CreatePostsDataStore {
    var userId : Int? {get set}
}

class CreatePostsInteractor:CreatePostsInteractorProtocol, CreatePostsDataStore {
    var presenter : CreatePostsPresenterProtocol?
    let worker : PostsWorker = PostsWorker(dataStore: ApiStore.instance)
    var userId: Int?
    
    func createPost(title: String, body: String) {
        let request = CreatePostsRequest(title: title, body: body, userId: 1)
        worker.createPosts(request: request,completionHandler: {(res,alert,err) in
            if err == nil {
                self.presenter?.showSuccess()
            } else {
                self.presenter?.showFail()
            }
        })
    }
    
    func getPosts() {
        worker.getPosts(userId:nil,completionHandler: {(res,alert,err) in
            if res != nil && res!.count > 0 {
                self.presenter?.showPosts(res: res!)
            }
        })
        
        worker.getPosts(userId:userId,completionHandler: {(res,alert,err) in
            if res != nil && res!.count > 0 {
                self.presenter?.showAllPostsForUserId(res: res!)
            }
        })
    }
    
    func getPostsForUserId() {
        worker.getPostsForUserId(userId:userId ?? 0,completionHandler: {(res,alert,err) in
            if res != nil {
                self.presenter?.showPostsForUserId(res: res!)
            }
        })
    }
}
