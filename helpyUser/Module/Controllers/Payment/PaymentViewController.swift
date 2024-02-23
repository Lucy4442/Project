//
//  PaymentViewController.swift
//  helpyUser
//
//  Created by mac on 04/01/21.
//

import UIKit

class PaymentViewController: UIViewController { 
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var PaymentView: UIView!
    @IBOutlet weak var btnAddNew: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        Set_navigationBar(Title: "Payment Method", isneedback: true)
        setUpFont()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    func setUpFont(){
        titleLabel.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 48)
        DescriptionLabel.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 42)
        btnAddNew.titleLabel?.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 42)
    }
    override func viewDidLayoutSubviews() {
        PaymentView.roundCorners([.allCorners], radius: 20)
        btnAddNew.cornerRadius = btnAddNew.frame.size.height / 2
    }
    @IBAction func btnAddnewTapped(_ sender: UIButton) {
            let AddNewPaymentVC = AddNewPaymentViewController.instantiate(fromAppStoryboard: .Payment)
            AddNewPaymentVC.isFirsttime = true
            navigationController?.pushViewController(AddNewPaymentVC, animated: true)
    }    
}
