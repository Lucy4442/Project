//
//  HelpDetailViewController.swift
//  HelpyService
//
//  Created by mac on 01/01/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class HelpDetailViewController: UIViewController {
    @IBOutlet weak var TitleView: UIView!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var btnMorehelp: UIButton!
    @IBOutlet weak var DetailView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMorehelp.setAttributedTitle(NSAttributedString(string: "MORE \nHELP"), for: .normal)
        btnMorehelp.setTitleColor(UIColor.white, for: .normal)
        btnMorehelp.titleLabel?.textAlignment = .center
        btnMorehelp.titleLabel?.font = UIFont(name: "System", size: 11)
        Set_navigationBar(Title: "Booking Services", isneedback: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLayoutSubviews() {
        btnMorehelp.cornerRadius = btnMorehelp.frame.size.height / 2
    }

    @IBAction func btnMoreHelpTapped(_ sender: UIButton) {
        print("More Help Tapeed.....")
        let MoreHelpVC = MoreHelpViewController.instantiate(fromAppStoryboard: .Menu)
        navigationController?.pushViewController(MoreHelpVC, animated: true)
    }
    
}
