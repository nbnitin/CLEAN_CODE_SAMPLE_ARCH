//
//  UsersRouter.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

//this is the router file, this will route to one vc to other

import Foundation

protocol UserRouterProtocol{
    func routeToCreatePosts(userId:Int)
    func routeToPhotos()
}

class UsersRouter: UserRouterProtocol {
    
    weak var vc : ViewController?
    
    func routeToCreatePosts(userId:Int) {
        let destinationVC =  CreatePostsViewController.instantiateFromStoryboard(
            storyboardName: StoryboardName.posts.rawValue,
            storyboardId: StoryboardVC.createPosts.rawValue)
        var destinationDS = destinationVC.router!.dataStore!
        passDataToCreatePosts(userId:userId,destination: &destinationDS)
        navigateToCreatePosts(source: vc!, destination: destinationVC)
    }
    
    // MARK: Navigation
    private func navigateToCreatePosts(source: ViewController,
                                       destination: CreatePostsViewController) {
        //routing type 1
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    private func passDataToCreatePosts(userId:Int,destination: inout CreatePostsDataStore) {
        destination.userId = userId
    }
    
    //MARK: route to photos
    func routeToPhotos(){
        let destinationVC = PhotosViewController.instantiateFromStoryboard(
            storyboardName: StoryboardName.photos.rawValue,
            storyboardId: StoryboardVC.getPhotos.rawValue)
        navigateToPhotos(source: vc!, destination: destinationVC)
    }
    
    // MAKR: navigate to photos
    func navigateToPhotos(source: ViewController, destination: PhotosViewController) {
        //routing type 2
        source.addChild(destination)
        source.view.addSubview(destination.view)
        destination.didMove(toParent: source)
    }

}
