//
//  ViewController.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

// this is the vc to show all users, from here we can route to all photos and posts

import UIKit

//protocol
protocol ViewControllerDisplayLogicProtocol {
    func displayAllUsers(res:[AllUsers]?)
}

class ViewController: UIViewController {
    
    //outlets
    @IBOutlet var userTableView: UITableView!
    
    //variables
    var interactor: UserInteractorProtocol?
    var router : UserRouterProtocol?
    var allUsers : [AllUsers] = [AllUsers]()
   // var router: (RegisterDeviceRouterProtocol)?
    
    //setup
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        let interactor = UserInteractor()
        self.interactor = interactor
        let presenter = UserPresenter(vc: self)
        interactor.presenter = presenter
        let router = UsersRouter()
        router.vc = self
        self.router = router
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        interactor?.getAllUsers()
    }

    //MARK: routing to photos
    @IBAction func goToPhotosAction(_ sender: Any) {
        router?.routeToPhotos()
    }
    
}

//MARK: view controller table delegate
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        cell.lblName.text = allUsers[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router?.routeToCreatePosts(userId: allUsers[indexPath.row].id ?? 0)
    }
}

//MARK: view controller display logic protocol code
extension ViewController:ViewControllerDisplayLogicProtocol {
    func displayAllUsers(res: [AllUsers]?) {
        allUsers = res ?? [AllUsers]()
        
        if allUsers.count > 0 {
            userTableView.reloadData()
        }
    }
   
}
