//
//  AboutusViewController.swift
//  HelpyService
//
//  Created by mac on 01/01/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class AboutusViewController: UIViewController {

    @IBOutlet weak var DetailView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Set_navigationBar(Title: "About us", isneedback: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.setGradient_Nav(Title: "About us", isneedback: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLayoutSubviews() {
        DetailView.roundCorners([.topLeft, .topRight], radius: 15)
    }

  

}
