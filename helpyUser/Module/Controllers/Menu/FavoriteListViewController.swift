//
//  FavoriteListViewController.swift
//  helpyUser
//
//  Created by mac on 08/01/21.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    @IBOutlet weak var FavoriteListCollectionView: UICollectionView!
    
    //MARK: Constant
    let HARIZONTAL_SPCE_IMAGE: CGFloat     = 10
    let VERTICAL_SPCE_IMAGE: CGFloat      = 10
    let COLUMN_IMAGE: CGFloat          = 2
    var favoriteData : FavoriteList?
    var orderBookingID : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNIB()
        Set_navigationBar(Title: "Favorite List", isneedback: true)
        FavoriteListData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // self.setGradient_Nav(Title: "Favorite List", isneedback: true)
    }
    func setUpNIB(){
        FavoriteListCollectionView.register(UINib(nibName: FavoriteListCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FavoriteListCollectionViewCell.identifier)
    }
    
    func FavoriteListData(){
        LoaderManager.showLoader()
        APIManager.share.GetFavoriteListData { (Result) in
            LoaderManager.hideLoader()
            switch Result{
            case .success(let response):
                print(response)
                self.favoriteData = response
                self.FavoriteListCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension FavoriteListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteData?.data?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DetailVC = ContactDetailViewController.instantiate(fromAppStoryboard: .Order)
        DetailVC.orderBookingID = favoriteData?.data?[indexPath.row].id ?? 0
        navigationController?.pushViewController(DetailVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteListCollectionViewCell.identifier, for: indexPath) as! FavoriteListCollectionViewCell
        cell.configureCell(data: favoriteData?.data?[indexPath.row])
        return cell
    }
    
}
extension FavoriteListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return HARIZONTAL_SPCE_IMAGE }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return VERTICAL_SPCE_IMAGE }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - ((COLUMN_IMAGE - 1) * HARIZONTAL_SPCE_IMAGE)) / COLUMN_IMAGE
        return CGSize(width: width, height: width)
    }
    
}
