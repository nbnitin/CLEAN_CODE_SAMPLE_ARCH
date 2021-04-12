//
//  PhotosViewController.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/8/21.
//

import UIKit

protocol PhotosViewControllerDisplayProtocol {
    func showPhotos(res: [GetAllPhotosResponse])
}

class PhotosViewController: UIViewController {

    @IBOutlet var photosCollectionView: UICollectionView!
    
    var photoData : [GetAllPhotosResponse] = [GetAllPhotosResponse]()
    var interactor : PhotoVCInteractorProtocol?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        let interactor = PhotoVCInteractor()
        self.interactor = interactor
        let presenter = PhotoVCPresenter(vc: self)
        interactor.presenter = presenter
    }
    
    override func viewDidLoad() {
        interactor?.getAllPhotos()
    }
}

extension PhotosViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotosCollectionViewCell
        cell.imgView.loadImageUsingUrlString(urlString: photoData[indexPath.row].url ?? "", spinner: cell.imgView.showActivityIndicator(), defaultImageName: "")
        return cell
    }
}

extension PhotosViewController: PhotosViewControllerDisplayProtocol {
    func showPhotos(res: [GetAllPhotosResponse]) {
        if res.count > 0 {
            photoData = res
            photosCollectionView.reloadData()
        }
    }
}
