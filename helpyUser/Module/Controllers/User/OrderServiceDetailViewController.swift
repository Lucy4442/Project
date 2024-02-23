//
//  OrderServiceDetailViewController.swift
//  Helpy
//
//  Created by mac on 28/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class OrderServiceDetailViewController: UIViewController {

    @IBOutlet weak var OrderServiceTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupNavigationUI()
        setUpNIB()
        Set_navigationBar(Title: "Order - Cleaning Service", isneedback: true)
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    func setUpNIB() {
        OrderServiceTableview.register(UINib(nibName: "JobDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "JobDetailTableViewCell")
        OrderServiceTableview.register(UINib(nibName: "EmptyJobTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyJobTableViewCell")
    }
    func SetupNavigationUI(){
        let BtnRight = UIButton(type: .custom)
        BtnRight.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        BtnRight.setImage(UIImage(named:"horizonatal"), for: .normal)
        let RightBarItem = UIBarButtonItem(customView: BtnRight)
        let rightWidth = RightBarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
        rightWidth?.isActive = true
        let rightHeight = RightBarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
        rightHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = RightBarItem
    }
}
extension OrderServiceDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell  = OrderServiceTableview.dequeueReusableCell(withIdentifier: "JobDetailTableViewCell", for: indexPath) as! JobDetailTableViewCell
            //cell.setUpData(with: .Service)
            return cell
        case 1:
            let cell  = OrderServiceTableview.dequeueReusableCell(withIdentifier: "EmptyJobTableViewCell", for: indexPath) as! EmptyJobTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
}
