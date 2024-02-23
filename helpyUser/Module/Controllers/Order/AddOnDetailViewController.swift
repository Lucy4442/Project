//
//  AddOnDetailViewController.swift
//  helpyUser
//
//  Created by mac on 29/06/21.
//

import UIKit

class AddOnDetailViewController: UIViewController {
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mianView: UIView!
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    var AddOnArray = [Addon]()
    var index: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        Set_navigationBar(Title: "AddOn - Detail", isneedback: true)
        setUpFont()
        configureData()
    }
    override func viewDidLayoutSubviews() {
        infoView.roundCorners([.allCorners], radius: 20)
    }
    func setUpFont(){
        priceLabel.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
        priceLabel.textColor = UIColor.App_Red
        titleLabel.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 46)
        titleLabel.textColor = UIColor.App_NavyBlue
        DescriptionLabel.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
        DescriptionLabel.textColor = UIColor.App_Gray
    }
    func configureData(){
        titleLabel.text = AddOnArray[index].addonName
        priceLabel.text = "Price: "+"$"+String(AddOnArray[index].price ?? 0)
        DescriptionLabel.text =  AddOnArray[index].AddonDescription
    }
}
