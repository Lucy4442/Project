//
//  NotificationViewController.swift
//  helpyUser
//
//  Created by mac on 08/01/21.
//

import UIKit

class NotificationViewController: UIViewController {
    @IBOutlet weak var NotificationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNIB()
        Set_navigationBar(Title: "Notification", isneedback: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    func setUpNIB(){
        NotificationTableView.register(UINib(nibName: NotificationTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NotificationTableViewCell.identifier)
    }

}
extension NotificationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier, for: indexPath) as! NotificationTableViewCell
        return cell
    }
    
    
}
