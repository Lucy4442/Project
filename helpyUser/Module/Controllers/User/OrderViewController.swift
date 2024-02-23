//
//  OrderViewController.swift
//  Helpy
//
//  Created by mac on 24/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    
    @IBOutlet weak var OrderSegment: UISegmentedControl!
    @IBOutlet weak var OrderListTableView: UITableView!
    @IBOutlet weak var emptyPlaceHolder: UIView!
    
    var refreshControl = UIRefreshControl()
    
    let segSelectedAttributes: NSDictionary = [
        NSAttributedString.Key.foregroundColor: UIColor.white]
    
    var orderRequestListArray = [OngoingOrder]()
    var ongoingOrderListArray = [OngoingOrder]()
    var completedOrderListArray = [OngoingOrder]()
    var cancelOrderListArray = [OngoingOrder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.tintColor = UIColor.App_LightBlue
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        OrderListTableView.addSubview(refreshControl)
        OrderSegment.setTitleTextAttributes(segSelectedAttributes as? [NSAttributedString.Key : Any], for: .selected)
        OrderSegment.selectedSegmentIndex = 0
        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
        setUpNIB()
        Set_navigationBar(Title: "Order", isneedback: true)
        self.showEmptyPlaceHolderIfNeeded()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.getOrderList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @objc func refresh() {
        self.getOrderList()
        self.OrderListTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func setUpNIB() {
        OrderListTableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTableViewCell")
        OrderListTableView.register(UINib(nibName: "PreviousOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "PreviousOrderTableViewCell")
    }
    
    func getOrderList() {
        LoaderManager.showLoader()
        APIManager.share.GetOrderListData { (Result) in
            LoaderManager.hideLoader()
            switch Result {
            case .success(let response):
                self.orderRequestListArray = response.data?.orderRequest ?? [OngoingOrder]()
                self.ongoingOrderListArray = response.data?.ongoingOrder ?? [OngoingOrder]()
                self.completedOrderListArray = response.data?.completedOrder ?? [OngoingOrder]()
                self.cancelOrderListArray = response.data?.cancelOrder ?? [OngoingOrder]()
                self.OrderListTableView.reloadData()
                self.showEmptyPlaceHolderIfNeeded()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
                print("error: \(error)")
            }
        }
    }
    
    func showEmptyPlaceHolderIfNeeded() {
        emptyPlaceHolder.isHidden = true
        switch OrderSegment.selectedSegmentIndex {
        case 0:
            emptyPlaceHolder.isHidden = orderRequestListArray.count != 0
        case 1:
            emptyPlaceHolder.isHidden = ongoingOrderListArray.count != 0
        case 2:
            emptyPlaceHolder.isHidden = completedOrderListArray.count != 0
        case 3:
            emptyPlaceHolder.isHidden = cancelOrderListArray.count != 0
        default:
            break;
        }
    }
    
    @IBAction func OrderSelectionTapped(_ sender: UISegmentedControl) {
         OrderListTableView.reloadData()
        self.showEmptyPlaceHolderIfNeeded()
    }
}
extension OrderViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch OrderSegment.selectedSegmentIndex {
        case 0:
            return orderRequestListArray.count
        case 1:
            return ongoingOrderListArray.count
        case 2:
            return completedOrderListArray.count
        case 3:
            return cancelOrderListArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch OrderSegment.selectedSegmentIndex {
        case 0:
            let cell = OrderListTableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
            cell.NextView.isHidden = false
            cell.OrderData = orderRequestListArray[indexPath.row]
            cell.paymentRequiredLabel.isHidden = orderRequestListArray[indexPath.row].status != 0
            return cell
        case 1:
            let cell = OrderListTableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
            cell.NextView.isHidden = false
            cell.OrderData = ongoingOrderListArray[indexPath.row]
            cell.paymentRequiredLabel.isHidden = true
            return cell
        case 2:
            let cell = OrderListTableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
            cell.NextView.isHidden = false
            cell.OrderData = completedOrderListArray[indexPath.row]
            cell.paymentRequiredLabel.isHidden = true
            return cell
        case 3:
            let cell = OrderListTableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
            cell.NextView.isHidden = true
            cell.OrderData = cancelOrderListArray[indexPath.row]
            cell.paymentRequiredLabel.isHidden = true
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch OrderSegment.selectedSegmentIndex {
        case 0:
            let OrderDetailVC = OrderDetailViewController.instantiate(fromAppStoryboard: .Order)
            OrderDetailVC.orderBookingID = orderRequestListArray[indexPath.row].id ?? 0
            OrderDetailVC.isPendingPayment = orderRequestListArray[indexPath.row].status == 0
            navigationController?.pushViewController(OrderDetailVC, animated: true)
        case 1:
            let OrderDetailVC = OrderDetailViewController.instantiate(fromAppStoryboard: .Order)
            OrderDetailVC.orderBookingID = ongoingOrderListArray[indexPath.row].id ?? 0
            OrderDetailVC.isFromRequest = true
            navigationController?.pushViewController(OrderDetailVC, animated: true)
        case 2:
            let CompleteVC = CompleteJobViewController.instantiate(fromAppStoryboard: .Order)
            CompleteVC.orderBookingID = completedOrderListArray[indexPath.row].id ?? 0
            navigationController?.pushViewController(CompleteVC, animated: true)
        default:
            break
        }
    }
}
