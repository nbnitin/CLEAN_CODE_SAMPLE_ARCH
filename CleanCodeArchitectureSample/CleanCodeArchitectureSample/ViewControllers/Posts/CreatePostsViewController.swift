//
//  PostsViewController.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/6/21.
//

import UIKit

protocol CreatePostsViewControllerProtocol {
    func showMessage(message:String)
    func showPosts(res:[CreatePostsResponse])
    func showPostsForUserId(res:CreatePostsResponse)
    func showAllPostsForUserId(res:[CreatePostsResponse])
}

class CreatePostsViewController: UIViewController {
    
    var interactor : CreatePostsInteractorProtocol?
    var router : (CreatePostsDataPassing & CreatePostsRouterProtocol)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        let interactor = CreatePostsInteractor()
        self.interactor = interactor
        let presenter = CreatePostsPresenter(vc: self)
        interactor.presenter = presenter
        let router = CreatePostsRouter()
        router.vc = self
        self.router = router
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("I am user id",router?.dataStore?.userId)
        // Do any additional setup after loading the view.
        interactor?.createPost(title: "hi", body: "hello")
        interactor?.getPosts()
        interactor?.getPostsForUserId()
    }

}

extension CreatePostsViewController:CreatePostsViewControllerProtocol {
    
    func showMessage(message:String) {
        print(message)
    }
    
    func showPosts(res: [CreatePostsResponse]) {
        print("i am all posts",res)
    }
    
    func showPostsForUserId(res: CreatePostsResponse) {
        print("i am user id posts",res)
    }
    
    func showAllPostsForUserId(res: [CreatePostsResponse]) {
        print("i am user id all posts",res)
    }
}
