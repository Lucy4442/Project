//
//  CategoriesTableViewCell.swift
//  Helpy
//
//  Created by mac on 18/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol CategoriesDelegate {
    func CategoriesAction(index: IndexPath, ID: String)
}

class CategoriesTableViewCell: UITableViewCell {
    var img = [#imageLiteral(resourceName: "homecleaning"), #imageLiteral(resourceName: "car"), #imageLiteral(resourceName: "plumber"), #imageLiteral(resourceName: "iron")]
    var services = ["Home Cleaning","Car Wash", "Plumber","Laundary"]
    @IBOutlet var imgView: UIImageView!
    @IBOutlet weak var CategoriesCollectionView: UICollectionView!
    
    var superVC: UIViewController?
    var parentServicesData : ParentServices?
    var finalID: String = ""
    var Deleagte: CategoriesDelegate?
    var ArrJob = [CleaningJob]()
    
    // Grid Info
    private var minimumInterSpacing : CGFloat = 10
    private var numberOfItemsInRow : CGFloat = 3
    private var edgeInsetPadding : CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        CategoriesCollectionView.delegate = self
        CategoriesCollectionView.dataSource = self
        CategoriesCollectionView.register(UINib(nibName: "CleaningJobCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CleaningJobCollectionViewCell")
        self.reload()
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.CategoriesCollectionView.reloadData()
            self.CategoriesCollectionView.layoutIfNeeded()
        }
    }
}

extension CategoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInterSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInterSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = UIEdgeInsets(top: 10, left: 5, bottom: 20, right: 5)
        edgeInsetPadding = inset.left + inset.right
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (CGFloat(Int(collectionView.frame.size.width)) - (numberOfItemsInRow - 1) * minimumInterSpacing - edgeInsetPadding) / numberOfItemsInRow
        return CGSize(width: width, height: width + 10)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return img.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CategoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "CleaningJobCollectionViewCell", for: indexPath) as! CleaningJobCollectionViewCell
//        cell.ConfigureCell(data: parentServicesData?.Servicedata?[indexPath.row])
        cell.ImgCleaningJob.image = img[indexPath.row]
        cell.CleaningJobTitle.text = services[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if ((parentServicesData?.Servicedata?[indexPath.row].isselected) != nil) {
//            parentServicesData?.Servicedata?[indexPath.row].isselected = false
//        } else {
//            parentServicesData?.Servicedata?[indexPath.row].isselected = true
//        }
//        finalID = String(parentServicesData?.Servicedata?[indexPath.row].id ?? 0)
//        collectionView.reloadItems(at: [indexPath])
        Deleagte?.CategoriesAction(index: indexPath, ID: "0")
    }
/*
 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> UIViewController {
         let st = UIStoryboard(name: "User", bundle: nil)
         let vc = st.instantiateViewController(withIdentifier: "ScheduleViewController") as! ScheduleViewController
         return vc
     }
 */
}
