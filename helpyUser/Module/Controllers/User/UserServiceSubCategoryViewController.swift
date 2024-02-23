//
//  UserServiceSubCategoryViewController.swift
//  helpyUser
//
//  Created by mac on 22/05/21.
//

import Foundation
import UIKit

class UserServiceSubCategoryViewController: UIViewController {

    @IBOutlet weak var ServicetableView: UITableView!
    var finalID: String = ""
    var subSubCategoryArray = [ServiceDetail]()
    var mainCategoryArray = [ServiceDetail]()
    var ArrService = [UserService]()
    var fromNewOrder = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNIB()
        Set_navigationBar(Title: "Cleaning Service", isneedback: true)
        ServicetableView.separatorStyle = .none
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    func setUpNIB(){
        ServicetableView.register(UINib(nibName: "UserServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "UserServiceTableViewCell")
    }
}
extension UserServiceSubCategoryViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return subSubCategoryArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subSubCategoryArray[section].subsubcategory?.count ?? 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return view.frame.height * 0.15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ServicetableView.dequeueReusableCell(withIdentifier: "UserServiceTableViewCell", for: indexPath) as! UserServiceTableViewCell
        cell.ConfigureCell(data: subSubCategoryArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let UserServiceVC = AddNeworderViewController.instantiate(fromAppStoryboard: .User)
        UserServiceVC.subSubCategoryArray = self.subSubCategoryArray[indexPath.row]
        UserServiceVC.mainCategoryObject = self.mainCategoryArray[indexPath.row]
        self.navigationController?.pushViewController(UserServiceVC, animated: true)
    }
}

