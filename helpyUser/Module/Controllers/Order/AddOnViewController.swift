//
//  AddOnViewController.swift
//  helpyUser
//
//  Created by mac on 28/06/21.
//

import UIKit
protocol EditAddonDelegate {
    func EditAddOnAction(addOnArray: [Addon])
}

class AddOnViewController: UIViewController {

    @IBOutlet weak var addOnTableview: UITableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnNext: UIButton!
    
    var isUpdateOrder = false
    var AddOnArray = [Addon]()
    var subSubCategoryArray : ServiceDetail?
    var mainCategoryArray : ServiceDetail?
    var index = 0
    var Indexsection = 0
    var ParentSection = 0
    var subserviceID : Int = 0
    var delegate : EditAddonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addOnTableview.delegate = self
        addOnTableview.dataSource = self
        setupNIB()
        Set_navigationBar(Title: "Add On", isneedback: true)
        btnNext.cornerRadius = btnNext.frame.size.width / 2
        if isUpdateOrder == true{
            AddonData()
        }else{}

    }
    
    func setupNIB(){
        addOnTableview.register(UINib(nibName: AddOnTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AddOnTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addOnTableview.reloadData()
    }
    @IBAction func NextTapped(_ sender: UIButton) {
        if isUpdateOrder == true{
            let mainArray = AddOnArray.filter { (value) -> Bool in
                value.isSelected == true
            }
            self.delegate?.EditAddOnAction(addOnArray: mainArray)
            navigationController?.popViewController(animated: true)
        }else{
            let mainArray = AddOnArray.filter { (value) -> Bool in
                value.isSelected == true
            }
            let AddVC = AddNeworderViewController.instantiate(fromAppStoryboard: .User)
            AddVC.AddOnArray = mainArray
            AddVC.Delegate = self
            
            /// if we enable this notification will not come on provider side
//            AddVC.subSubCategoryArray = self.subSubCategoryArray
            AddVC.subCategoryArray = self.subSubCategoryArray
            AddVC.mainCategoryObject = self.mainCategoryArray
            navigationController?.pushViewController(AddVC, animated: true)
        }
        
    }
    
    func AddonData(){
        APIManager.share.addOn_Data(service_id: String(subserviceID)) { (Result) in
            switch Result{
            case .success(let response):
                self.AddOnArray = response.data ?? [Addon]()
                self.view.makeToast(response.message)
                self.addOnTableview.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}
extension AddOnViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddOnArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddOnTableViewCell.identifier, for: indexPath) as!  AddOnTableViewCell
        index = indexPath.row
        Indexsection = indexPath.section
        cell.configureCell(data: AddOnArray[indexPath.row])
        cell.btnDetail.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if AddOnArray[indexPath.row].isSelected == true{
            AddOnArray[indexPath.row].isSelected = false
        }else{
            AddOnArray[indexPath.row].isSelected = true
        }
        addOnTableview.reloadData()
    }
    
}
extension AddOnViewController: addOnDelegate, RemoveAddonDelegate{
    func RemoveCheckmark(Object: Addon) {
        let index = AddOnArray.firstIndex { $0.addonId == Object.addonId }
        if let index = index {
            AddOnArray[index] = Object
            addOnTableview.reloadData()
        }
    }
    func addOnAction(sender: UIButton) {
        let Vc = AddOnDetailViewController.instantiate(fromAppStoryboard: .User)
        Vc.index = sender.tag
        Vc.AddOnArray = AddOnArray
        navigationController?.pushViewController(Vc, animated: true)
    }
    
    
}
