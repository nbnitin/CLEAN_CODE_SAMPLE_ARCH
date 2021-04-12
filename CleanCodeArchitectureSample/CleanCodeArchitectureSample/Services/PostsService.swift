//
//  PostsService.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/6/21.
//

import Foundation
protocol PostsServiceProtocol {
    
    func createPosts(postsRequest:CreatePostsRequest,completionHandler: @escaping DictionaryNetworkResponseHandler<CreatePostsResponse>)
    func getPosts(userId:Int?,completionHandler: @escaping ArrayNetworkResponseHandler<CreatePostsResponse>)
    func getPostsForUserId(userId:Int,completionHandler: @escaping DictionaryNetworkResponseHandler<CreatePostsResponse>)
}

class PostsService: BaseService, PostsServiceProtocol {
    
    func createPosts(postsRequest:CreatePostsRequest,completionHandler: @escaping DictionaryNetworkResponseHandler<CreatePostsResponse>){
        self.networkService.performRequest(for: CreatePostsResponse.self, route: PostsApiRouter.createPosts(request: postsRequest), completion: {(res,alert,err) in
                completionHandler(res,alert,err)
        })
    }
    
    func getPosts(userId:Int?,completionHandler: @escaping ArrayNetworkResponseHandler<CreatePostsResponse>){
        if userId == nil {
            self.networkService.performArrayRequest(for: CreatePostsResponse.self, route: PostsApiRouter.getPosts, completion: {(res,alert,err) in
                    completionHandler(res,alert,err)
            })
        } else {
            self.networkService.performArrayRequest(for: CreatePostsResponse.self, route: PostsApiRouter.getAllPostsForUserId(userId: userId!), completion: {(res,alert,err) in
                    completionHandler(res,alert,err)
            })
        }
    }
    
    func getPostsForUserId(userId:Int,completionHandler: @escaping DictionaryNetworkResponseHandler<CreatePostsResponse>){
        self.networkService.performRequest(for: CreatePostsResponse.self, route: PostsApiRouter.getPostsForUserId(userId: userId), completion: {(res,alert,err) in
                completionHandler(res,alert,err)
        })
    }
}
