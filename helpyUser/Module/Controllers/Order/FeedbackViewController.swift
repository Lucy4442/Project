//
//  FeedbackViewController.swift
//  helpyUser
//
//  Created by mac on 22/06/21.
//

import UIKit
import Cosmos

class FeedbackViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var lblrate: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnfavorite: UIButton!
    @IBOutlet weak var Profile: UIImageView!
    @IBOutlet weak var imgBannner: UIImageView!
    @IBOutlet weak var txtComment: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var StarView: CosmosView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Set_navigationBar(Title: "Feedback", isneedback: true)
        StarView.settings.fillMode = .full
        StarView.didTouchCosmos = didTouchCosmos(_:)
        StarView.didFinishTouchingCosmos = didFinishTouchingCosmos(_:)
        lblrate.text = "\(Int(StarView.rating))/5"
        updateRating(requiredRating: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLayoutSubviews() {
        btnSubmit.cornerRadius = btnSubmit.frame.size.width  / 2
        userView.roundCorners([.allCorners], radius: 20)
        ratingView.roundCorners([.allCorners], radius: 20)
        txtComment.roundCorners([.allCorners], radius: 20)
    }
    func AddFeedback_Data(){
        LoaderManager.showLoader()
        APIManager.share.AddFeedback_Data(ProviderID: "21", Rating: "\(StarView.rating)", Comment: "\(txtComment.text ?? "")") { (Result) in
            LoaderManager.hideLoader()
            switch Result{
            case .success(let response):
                print(response)
                if response.status == 1{
                    AppUtility.alertMessage(response.message ?? "", viewcontroller: self)
                }else{
                    AppUtility.alertMessage(response.message ?? "", viewcontroller: self)
                }
            case .failure(let error):
                AppUtility.alertMessage(error.localizedDescription, viewcontroller: self)
            }
        }
    }
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        AddFeedback_Data()
        navigationController?.popViewController(animated: true)
    }
    private func updateRating(requiredRating: Double?) {
        var newRatingValue: Double = 0.0
        if let nonEmptyRequiredRating = requiredRating {
            newRatingValue = nonEmptyRequiredRating
        } else {
            newRatingValue = StarView.rating
        }
    }
    private func didTouchCosmos(_ rating: Double) {
        updateRating(requiredRating: rating)
        lblrate.text = "\(Int(rating))/5"
        lblrate.textColor = UIColor.App_NavyBlue
    }
    private func didFinishTouchingCosmos(_ rating: Double) {
        
        self.lblrate.text = "\(Int(rating))/5"
        lblrate.textColor = UIColor.App_NavyBlue
    }
}
