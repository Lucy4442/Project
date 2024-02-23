//
//  AddCustomOrderViewController.swift
//  Helpy
//
//  Created by mac on 22/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class AddCustomOrderViewController: UIViewController {

    @IBOutlet weak var CustomOrderTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNIB()
        Set_navigationBar(Title: "Add Custom Order", isneedback: true)
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    func setUpNIB(){
        CustomOrderTableView.register(UINib(nibName: "CustomJobTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomJobTableViewCell")
        CustomOrderTableView.register(UINib(nibName: "ScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "ScheduleTableViewCell")
        CustomOrderTableView.register(UINib(nibName: "AddAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AddAddressTableViewCell")
    }
    
}
extension AddCustomOrderViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = CustomOrderTableView.dequeueReusableCell(withIdentifier: "CustomJobTableViewCell", for: indexPath) as! CustomJobTableViewCell
            return cell
        case 1:
            let cell = CustomOrderTableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
            cell.imgView.image = UIImage(named: "DeliveryService")
            cell.btnPickupTime.setTitle("Single Way", for: .normal)
           // cell.btnDeliveryTime.setTitle("Pickup & Return", for: .normal)
            return cell
        case 2:
            let cell = CustomOrderTableView.dequeueReusableCell(withIdentifier: "AddAddressTableViewCell", for: indexPath) as! AddAddressTableViewCell
            cell.AddressView.isHidden = true
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch  indexPath.section {
        case 0:
            return view.frame.size.height * 0.25
        case 1:
            return view.frame.size.height * 0.3
        case 2:
            return view.frame.size.height * 0.2
        default:
            return CGFloat()
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView: HeaderView = UIView.fromNib()
            headerView.btnViewall.isHidden = true
            headerView.lblTitle.text = "Job Name"
            return headerView
        case 1:
            let headerView: HeaderView = UIView.fromNib()
            headerView.btnViewall.isHidden = true
            headerView.lblTitle.text = "Delivery Man"
            return headerView
        default:
            return UIView.init()
        }
    }
}
