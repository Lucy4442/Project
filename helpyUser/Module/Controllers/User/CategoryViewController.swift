//
//  CategoryViewController.swift
//  helpyUser
//
//  Created by mac on 01/06/21.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var img = [#imageLiteral(resourceName: "homecleaning"), #imageLiteral(resourceName: "car"), #imageLiteral(resourceName: "plumber"), #imageLiteral(resourceName: "iron")]
    var services = ["Home Cleaning","Car Wash", "Plumber","Laundary"]
    @IBOutlet weak var HomeTableview: UITableView!
    var parentServicesData : ParentServices?
    var finalID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeTableview.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesTableViewCell")
        Set_navigationBar(Title: "Services", isneedback: true)
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HomeTableview.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
        // cell.parentServicesData = parentServicesData
        // cell.finalID = finalID
        // cell.reload()
        // cell.superVC = self
        // cell.Deleagte = self
//        cell.imgView.image = img[indexPath.row]
        return cell
    }
}
extension CategoryViewController: CategoriesDelegate{
    func CategoriesAction(index: IndexPath, ID: String) {
//        if parentServicesData?.Servicedata?[index.row].isCart == 2{
//            if parentServicesData?.Servicedata?[index.row].cat_type == 0{
//                if parentServicesData?.Servicedata?[index.row].addons?.count == 0{
                    let AddVC = ScheduleViewController.instantiate(fromAppStoryboard: .User)
//                    AddVC.mainCategoryObject = self.parentServicesData?.Servicedata?[index.row]
                    self.navigationController?.pushViewController(AddVC, animated: true)
//                }else{
//                    let AddonVC = AddOnViewController.instantiate(fromAppStoryboard: .User)
//                    AddonVC.AddOnArray = self.parentServicesData?.Servicedata?[index.row].addons ?? [Addon]()
//                    AddonVC.ParentSection = index.row
//                    AddonVC.mainCategoryArray = self.parentServicesData?.Servicedata?[index.row]
//                    navigationController?.pushViewController(AddonVC, animated: true)
//                }
//            }else{
//                let UserServiceVC = UserServiceViewController.instantiate(fromAppStoryboard: .User)
//                UserServiceVC.finalID = ID
//                UserServiceVC.parentServiceData = self.parentServicesData?.Servicedata?[index.row]
//                navigationController?.pushViewController(UserServiceVC, animated: true)
//            }
//        }else{
//            let AddtoCartVC = AddToCartViewController.instantiate(fromAppStoryboard: .User)
//            AddtoCartVC.finalID = ID
//            AddtoCartVC.mainCategoryArray = self.parentServicesData?.Servicedata?[index.row]
//            navigationController?.pushViewController(AddtoCartVC, animated: true)
//        }
    }
    
    
}
