//
//  CreatePostsApiRouter.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/6/21.
//

import Foundation
import Alamofire

enum PostsApiRouter: APIRouter {
    case createPosts(request: CreatePostsRequest)
    case getPosts
    case getPostsForUserId(userId:Int)
    case getAllPostsForUserId(userId:Int)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .createPosts:
            return .post
        case .getPosts,.getPostsForUserId,.getAllPostsForUserId:
            return .get
        }
    }
    
    // MARK: - Path
    var endPoint: String {
        switch self {
        case .createPosts:
            return EndPoint.createPosts.rawValue
        case .getPosts:
            return EndPoint.createPosts.rawValue
        case .getPostsForUserId(let userId):
            return EndPoint.createPosts.rawValue + "/\(userId)"
        case .getAllPostsForUserId(let userId):
            return EndPoint.createPosts.rawValue + "?userId=\(userId)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .createPosts(let request):
            return JsonHelper.encode(request)
        case .getPosts,.getPostsForUserId,.getAllPostsForUserId:
            return nil
        }
    }
}
