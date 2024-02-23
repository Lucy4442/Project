//
//  UserMenuTableViewCell.swift
//  Helpy
//
//  Created by mac on 17/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class UserMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var UserMenuCollectionView: UICollectionView!
    
    var superVC: UIViewController?
    //TODO: Hide Notification and favorite list
    
    var MenuName = [LabelName.ORDER, LabelName.PAYMENT_METHOD, LabelName.ADDRESS]
    var MenuImage = [UIImage(named: ImageName.order)!, UIImage(named: ImageName.payment), UIImage(named: ImageName.Address)!]
    var cardDetail : GetCardDetails?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        UserMenuCollectionView.register(UINib(nibName: "UserMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserMenuCollectionViewCell")
        UserMenuCollectionView.delegate = self
        UserMenuCollectionView.dataSource = self
        if let layout = UserMenuCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
//MARK: ==========Collectionview Delegate & Datasource==========
extension UserMenuTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuName.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UserMenuCollectionView.frame.size.width / 2) - 70
        let height = (UserMenuCollectionView.frame.size.height - 30) / 2
        return CGSize(width: width, height:  height)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UserMenuCollectionView.dequeueReusableCell(withReuseIdentifier: "UserMenuCollectionViewCell", for: indexPath) as! UserMenuCollectionViewCell
        cell.menuImageView.image = MenuImage[indexPath.row]
        cell.lblMenuName.text = MenuName[indexPath.row]
        cell.layoutIfNeeded()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let OrderVC = OrderViewController.instantiate(fromAppStoryboard: .Order)
            superVC?.navigationController?.pushViewController(OrderVC, animated: true)
        }else if indexPath.row == 1 {
            if cardDetail?.data?.count == 0{
                let PaymentVC = PaymentViewController.instantiate(fromAppStoryboard: .Payment)
                superVC?.navigationController?.pushViewController(PaymentVC, animated: true)
            }else{
                let PaymentMethodVC = PaymentmethodViewController.instantiate(fromAppStoryboard: .Payment)
                superVC?.navigationController?.pushViewController(PaymentMethodVC, animated: true)
            }
        }else  if indexPath.row == 2 {
            let AddressmanagerVC = AddressManagerViewController.instantiate(fromAppStoryboard: .Address)
            superVC?.navigationController?.pushViewController(AddressmanagerVC, animated: true)
        }else  if indexPath.row == 3 {
            let FavoriteListVC = FavoriteListViewController.instantiate(fromAppStoryboard: .Menu)
            superVC?.navigationController?.pushViewController(FavoriteListVC, animated: true)
        }else  if indexPath.row == 4 {
            let NotificationVC = NotificationViewController.instantiate(fromAppStoryboard: .Menu)
            superVC?.navigationController?.pushViewController(NotificationVC, animated: true)
        }else{
            print("not a Address Block")
        }
        
    }
}
