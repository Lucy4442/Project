//
//  AddToCartViewController.swift
//  helpyUser
//
//  Created by mac on 01/07/21.
//

import UIKit
protocol EditCartDelegate {
    func  EditCartAction(count: Int)
}
class AddToCartViewController: UIViewController {
    @IBOutlet weak var AddtoCartTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var NextButton: UIButton!
    var finalID: String = ""
    var AddToCartData : ParentServices?
    var mainCategoryArray: ServiceDetail?
    var count : Int = 1
    var lableType: String?
    var orderBookingID : Int = 0
    var isUpdateCart = false
    var delegate: EditCartDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Set_navigationBar(Title: "Add To Cart", isneedback: true)
        setUpNIB()
        Get_SubServices_Data()
        NextButton.addTarget(self, action: #selector(NextButtonAction(sender:)), for: UIControl.Event.touchUpInside)
    }
    override func viewDidLayoutSubviews() {
        NextButton.cornerRadius = NextButton.frame.size.width / 2
    }
    override func viewWillAppear(_ animated: Bool) {
        AddtoCartTableView.reloadData()
    }
    @objc func NextButtonAction(sender: UIButton){
        if isUpdateCart == true{
            delegate?.EditCartAction(count: count)
            navigationController?.popViewController(animated: true)
        }else{
            let AddVC = AddNeworderViewController.instantiate(fromAppStoryboard: .User)
            AddVC.cartTotal = count
            AddVC.Labeltype = lableType
            AddVC.mainCategoryObject = self.mainCategoryArray
            navigationController?.pushViewController(AddVC, animated: true)
        }
    }
    func setUpNIB(){
        AddtoCartTableView.register(UINib(nibName: AddCartTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AddCartTableViewCell.identifier)
    }
    
    func Get_SubServices_Data(){
        LoaderManager.showLoader()
        APIManager.share.GetSubServiceData(serviceID: finalID ) { (Result) in
            LoaderManager.hideLoader()
            switch Result{
            case .success(let response):
                self.AddToCartData = response
                self.AddtoCartTableView.reloadData()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
}
extension AddToCartViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    } 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddCartTableViewCell.identifier, for: indexPath) as! AddCartTableViewCell
        
        if let cellData = AddToCartData?.Servicedata?[indexPath.row] {
            cell.configureCell(data: cellData)
            print("cell configured.")
        }
        
        if isUpdateCart == true{
//            cell.cartTitleLabel.text = lableType
        }else{
            lableType = cell.cartTitleLabel.text ?? ""
        }
       
        cell.cartCountLabel.text = String(count)
        cell.delegate = self
        return cell
    }
}
extension AddToCartViewController: AddRemoveCartDelegate{
    func addCartAction() {
        count = count + 1
        AddtoCartTableView.reloadData()
    }
    
    func removeCartAction() {
        if count <= 1{
            return
        }
        count = count - 1
        AddtoCartTableView.reloadData()
    }
    
}
