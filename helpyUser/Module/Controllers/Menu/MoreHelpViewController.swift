//
//  MoreHelpViewController.swift
//  helpyUser
//
//  Created by mac on 11/01/21.
//

import UIKit

class MoreHelpViewController: UIViewController {
    
    @IBOutlet weak var MorehelpTableView: UITableView!
    @IBOutlet weak var btnSend: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Set_navigationBar(Title: "More Help", isneedback: true)
        setUpNIB()
    }
    func setUpNIB(){
        MorehelpTableView.register(UINib(nibName: EmailAddressTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: EmailAddressTableViewCell.identifier)
        MorehelpTableView.register(UINib(nibName: EmailDescriptionTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: EmailDescriptionTableViewCell.identifier)
    }
    override func viewDidLayoutSubviews() {
        btnSend.cornerRadius = btnSend.frame.size.width / 2
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        let HelpVC = HelpViewController.instantiate(fromAppStoryboard: .Menu)
        navigationController?.pushViewController(HelpVC, animated: true)
    }
}
extension MoreHelpViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell  = MorehelpTableView.dequeueReusableCell(withIdentifier: EmailAddressTableViewCell.identifier, for: indexPath) as! EmailAddressTableViewCell
            return cell
        case 1:
            let cell  = MorehelpTableView.dequeueReusableCell(withIdentifier: EmailDescriptionTableViewCell.identifier, for: indexPath) as! EmailDescriptionTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView: HeaderView = UIView.fromNib()
        if section == 0 {
            headerView.lblTitle.text = "Email ID"
            headerView.btnViewall.isHidden = true
        }else{
            headerView.lblTitle.text = "Description"
            headerView.btnViewall.isHidden = true
        }
       
        return headerView
    }
}
