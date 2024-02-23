//
//  HelpViewController.swift
//  HelpyService
//
//  Created by mac on 01/01/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var helptableview: UITableView!
    var bookingService = [Help]()
    var payingService = [Help]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNIB()
        setUpData()
        Set_navigationBar(Title: "Help", isneedback: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // self.setGradient_Nav(Title: "Help", isneedback: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    func  setUpNIB(){
        helptableview.register(UINib(nibName: HelpTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: HelpTableViewCell.identifier)
        helptableview.register(UINib(nibName: CompleteJobTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CompleteJobTableViewCell.identifier)
    }
    func setUpData(){
        bookingService = [Help(Detail: "How to book a Service or How to cancel a booking?"),
                   Help(Detail: "How to reschedule my booking?"),
                   Help(Detail: "How can i contact the person?"),
                   Help(Detail: "How can i rate and review the service?"),
                   Help(Detail: "How can i book previous person for same service?")]
        payingService = [Help(Detail: "How to pay for the services?"),
                         Help(Detail: "Refund policy")]
    }
}
extension HelpViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return bookingService.count
        case 1:
            return payingService.count
        case 2:
            return 1
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = helptableview.dequeueReusableCell(withIdentifier: HelpTableViewCell.identifier, for: indexPath) as! HelpTableViewCell
            cell.help = bookingService[indexPath.row]
            return cell
        case 1:
            let cell = helptableview.dequeueReusableCell(withIdentifier: HelpTableViewCell.identifier, for: indexPath) as! HelpTableViewCell
            cell.help = payingService[indexPath.row]
            return cell
        case 2:
            let cell = helptableview.dequeueReusableCell(withIdentifier: CompleteJobTableViewCell.identifier, for: indexPath) as! CompleteJobTableViewCell
            cell.btnCompleteJob.setAttributedTitle(NSAttributedString(string: "MORE \nHELP"), for: .normal)
            cell.btnCompleteJob.setTitleColor(UIColor.white, for: .normal)
            cell.btnCompleteJob.titleLabel?.textAlignment = .center
            cell.btnCompleteJob.titleLabel?.font = UIFont(name: "System", size: 11)
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerview: HeaderView = UIView.fromNib()
            headerview.lblTitle.text = "Booking Services"
            headerview.btnViewall.isHidden = true
            return headerview
        case 1:
            let headerview: HeaderView = UIView.fromNib()
            headerview.lblTitle.text = "Paying for my Services"
            headerview.btnViewall.isHidden = true
            return headerview
        default:
            return UIView.init()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0{
                let HelpDetailVC = HelpDetailViewController.instantiate(fromAppStoryboard: .Menu)
                navigationController?.pushViewController(HelpDetailVC, animated: true)
            }
        default:
            break
        }
    }
}
extension HelpViewController: CompleteJobActionDelegate{
    func CompleteJobTapped() {
        let MoreHelpVC = MoreHelpViewController.instantiate(fromAppStoryboard: .Menu)
        navigationController?.pushViewController(MoreHelpVC, animated: true)
    }
}
