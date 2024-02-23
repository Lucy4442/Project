//
//  SearchViewController.swift
//  helpyUser
//
//  Created by mac on 01/02/21.
//

import UIKit

class SearchViewController: UIViewController {

    //var searchView : SearchView?
    @IBOutlet weak var SearchTableview: UITableView!
    var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 40, y: 0, width: 270, height: 20))
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setsearchView()
        setUpNIB()
    }
    
    func setsearchView(){
        //searchBar.placeholder = "Your placeholder"
        Set_navigationBar(Title: "", isneedback: true)
        searchBar.text = "carpet Cleaner"
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = .white
        } else {
            searchBar.barTintColor = .white
            print("Error")
        }
        
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.rightBarButtonItem = leftNavBarButton
    }
    func setUpNIB(){
        SearchTableview.register(UINib(nibName: UserServiceTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: UserServiceTableViewCell.identifier)
    }
}
extension SearchViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserServiceTableViewCell.identifier, for: indexPath) as! UserServiceTableViewCell
        cell.lblServiceName.text = "Carpet/ Sofa/ Cushions Cleaning Cleaning"
        cell.imgService.image = UIImage(named: ImageName.Cleaning)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.15
    }
    
}
