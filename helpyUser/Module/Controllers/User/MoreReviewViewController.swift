//
//  MoreReviewViewController.swift
//  helpyUser
//
//  Created by mac on 08/05/21.
//

import UIKit

class MoreReviewViewController: UIViewController {

    @IBOutlet weak var ReviewTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ReviewTableView.delegate = self
        ReviewTableView.dataSource = self
        SetUpNIB()
     //   setGradient_Nav()
        Set_navigationBar(Title: "More Review", isneedback: true)
    }
    func SetUpNIB(){
        ReviewTableView.register(UINib(nibName: FeedbackDetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FeedbackDetailTableViewCell.identifier)
    }
}
extension MoreReviewViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ReviewTableView.dequeueReusableCell(withIdentifier: FeedbackDetailTableViewCell.identifier, for: indexPath) as! FeedbackDetailTableViewCell
        return cell
    }
    
    
}
