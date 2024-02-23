//
//  PopUpViewController.swift
//  helpyUser
//
//  Created by mac on 08/02/21.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var PopUpView: UIView!
    @IBOutlet weak var btnEditOrder: UIButton!
    @IBOutlet weak var btnCancelOrder: UIButton!
    @IBOutlet weak var btnMoreHelp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFont()
    }
    override func viewDidLayoutSubviews() {
        PopUpView.roundCorners([.allCorners], radius: 15)
    }
    func setUpFont(){
        btnEditOrder.titleLabel?.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
        btnMoreHelp.titleLabel?.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
        btnCancelOrder.titleLabel?.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
    }
    
    @IBAction func btnEditOrderTapped(_ sender: UIButton) {
        print("Edit Order")
    }
    
    @IBAction func btnCancelOrderTapped(_ sender: UIButton) {
        print("Cancel Order")
    }
    
    @IBAction func btnMoreHelp(_ sender: UIButton){
        print("More Help")
    }
    
}
