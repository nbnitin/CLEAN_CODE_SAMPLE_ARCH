//
//  PostsWorker.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/6/21.
//

import Foundation

class PostsWorker:Worker{
    func createPosts(request:CreatePostsRequest,completionHandler: @escaping DictionaryNetworkResponseHandler<CreatePostsResponse>){
        dataStore.postService.createPosts(postsRequest: request,completionHandler: {(res,alert,err) in
            completionHandler(res,alert,err)
        })
    }
    
    func getPosts(userId:Int?,completionHandler: @escaping ArrayNetworkResponseHandler<CreatePostsResponse>) {
        dataStore.postService.getPosts(userId:userId,completionHandler: {(res,alert,err) in
            completionHandler(res,alert,err)
        })
    }
    
    func getPostsForUserId(userId:Int,completionHandler: @escaping DictionaryNetworkResponseHandler<CreatePostsResponse>) {
        dataStore.postService.getPostsForUserId(userId:userId,completionHandler: {(res,alert,err) in
            completionHandler(res,alert,err)
        })
    }
}
