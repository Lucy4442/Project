//
//  DocumentPopupViewController.swift
//  Helpy
//
//  Created by mac on 09/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
protocol LoadImageDelegate: AnyObject {
    func LoadImage(Index: Int, DocumentImage: UIImage?)
  //  func GalleryAction()
}
//MARK: ==========DocumentPopupViewController==========
class DocumentPopupViewController: BottomPopupViewController {
    
    //MARK: ==========Variable==========
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    var imagePicker: UIImagePickerController!
    var Delegate : LoadImageDelegate?
    var Index: Int?
    var superVC: UIViewController?
    
    //MARK: ==========Outlet==========
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var GallaryView: UIView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var CategoryView: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    
    //MARK: ==========viewDidLoad==========
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //MARK: ==========viewDidLayoutSubviews==========
    override func viewDidLayoutSubviews() {
        btnCancel.roundCorners([.allCorners], radius: 25)
        CategoryView.roundCorners([.topLeft, .topRight], radius: 25)
        GallaryView.roundCorners([.allCorners], radius: 25)
        cameraView.roundCorners([.allCorners], radius: 25)
    }
    
    //MARK: ==========Gallery Button Action==========
    @IBAction func btnGalleryTapped(_ sender: Any) {
//        dismiss(animated: true) {
            self.imagePicker = UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
//        }
    }
    
    //MARK: ==========Camera Button Action==========
    @IBAction func btnCameraTapped(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
//        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: ==========Cancel Button Action==========
    @IBAction func btnCancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: ==========Override Variable==========
    override var popupHeight: CGFloat { return height ?? CGFloat(380) }
    override var popupTopCornerRadius: CGFloat { return topCornerRadius ?? CGFloat(32) }
    override var popupPresentDuration: Double { return presentDuration ?? 0.8 }
    override var popupDismissDuration: Double { return dismissDuration ?? 1.0 }
    override var popupShouldDismissInteractivelty: Bool { return shouldDismissInteractivelty ?? true }
    override var popupDimmingViewAlpha: CGFloat { return 0.3 }
}

extension DocumentPopupViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        imgDocument.image = info[.originalImage] as? UIImage
        Delegate?.LoadImage(Index: Index ?? 0, DocumentImage: info[.originalImage] as? UIImage)
        imagePicker.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
}
