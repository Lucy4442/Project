//
//  PrivacyPolicyViewController.swift
//  helpyUser
//
//  Created by mac on 04/01/21.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    @IBOutlet weak var imgPrivacyPolicy: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var PrivacyPolicyView: UIView!
    @IBOutlet weak var copyrightView: UIView!
    @IBOutlet weak var DetailView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        Set_navigationBar(Title: "Privacy Policy", isneedback: true)
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // self.setGradient_Nav(Title: "Privacy Policy", isneedback: true)
    }
    override func viewDidLayoutSubviews() {
        PrivacyPolicyView.roundCorners([.allCorners], radius: 20)
    }
    

}
