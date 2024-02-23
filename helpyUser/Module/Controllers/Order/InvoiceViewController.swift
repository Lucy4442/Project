//
//  InvoiceViewController.swift
//  HelpyService
//
//  Created by mac on 08/06/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
import WebKit
class InvoiceViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var Invoicewebview: WKWebView!
    @IBOutlet weak var Loader: UIActivityIndicatorView!
    var UrlString: String?
    var invoiceDetail : InvoiceData?
    var orderBookingID : Int = 0
    
    var pdfURL : URL? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Set_navigationBar(Title: "Invoice Preview", isneedback: true)
        
        self.Loader.isHidden = false
        Loader.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        LoadURL_Data()
    }
    
    override func viewDidLayoutSubviews() {
        btnDownload.cornerRadius = btnDownload.frame.size.width / 2
    }
    
    func LoadURL_Data(){
        if let videoURL = URL(string: UrlString ?? ""){
            
            let request = URLRequest(url: videoURL)
            self.Invoicewebview.load(request)
            self.Invoicewebview.uiDelegate = self
            self.Invoicewebview.navigationDelegate = self
            Invoice_Data()
        }else{
            self.view.makeToast("Not Getting URL", duration: 1.0, position: .center)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.Loader.stopAnimating()
            self.Loader.isHidden = true
        }
    }
    
    func Invoice_Data(){
        LoaderManager.showLoader()
        APIManager.share.SendInvoiceData(Order_id: "\(orderBookingID)") { (Result) in
            LoaderManager.hideLoader()
            switch Result{
            case .success(let response):
                print("Response : \(response)")
                self.invoiceDetail = response
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func btnDownloadTapped(_ sender: UIButton) {
        if let url = pdfURL {
            loadPDFAndShare(url.path)
        } else {
            AppUtility.alertMessage("Can't download, Please try again letter.", viewcontroller: self)
        }
    }
    
}


extension InvoiceViewController {
    
    func loadPDFAndShare(_ docPath :String) {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: docPath){
            let pdfData = NSData(contentsOfFile: docPath)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [pdfData!], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            let appRoot = UIApplication.shared.keyWindow?.rootViewController
            appRoot?.present(activityViewController, animated: true, completion: nil)
        }
        else {
            print("document was not found")
        }
    }
    
}

extension InvoiceViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.pdfURL = renderPDFFromWebView(webView)
    }
    
    func renderPDFFromWebView(_ webView: WKWebView) -> URL {
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(webView.viewPrintFormatter(), startingAtPageAt: 0);
        let page = CGRect(x: 0, y: 10, width: webView.frame.size.width, height: webView.frame.size.height)
        let printable = page.insetBy(dx: 0, dy: 0)
        render.setValue(NSValue(cgRect: page), forKey: "paperRect")
        render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)
        for i in 1...render.numberOfPages {
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPage(at: i - 1, in: bounds)
        }
        UIGraphicsEndPDFContext()
        let fileName = "\(UUID().uuidString.prefix(5))_Invoice.pdf"
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path
        pdfData.write(toFile: "\(documentsPath)/\(fileName)", atomically: true)
        let tmpURL = URL(string: "\(documentsPath)/\(fileName)")!
        return tmpURL
    }
    
    
    
    
}

