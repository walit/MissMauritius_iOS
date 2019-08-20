//
//  PaymentResponseViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 28/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit
import SVProgressHUD

class PaymentResponseViewController: UIViewController {
    var obPlan = PlanModel()
    var url = String()
    var strPostData = String()
    var arrParams = NSArray()
    var payRequestId = String()
    @IBOutlet weak var webView_Content: UIWebView!
    @IBAction func btn_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
        
     loadWebView(url)
        
        
    }
    
    func loadWebView(_ strURL:String) {
        guard let url = URL.init(string: strURL) else {
            return
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postData: NSData = strPostData.data(using: String.Encoding.ascii, allowLossyConversion: true)! as NSData
        request.httpBody = postData as Data
        //        webView.loadRequest(request)
        // init and load request in webview.
        webView_Content.delegate = self
        webView_Content.loadRequest(request as URLRequest)
    }
    
}

extension PaymentResponseViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView){
        SVProgressHUD.show(withStatus: NSLocalizedString("loading...", comment: ""))
     //   print("webViewDidStartLoad")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
        print("webViewDidFinishLoad")
    }
    
    func webView(_webView: UIWebView, didFailLoadWithError error: NSError) {
        SVProgressHUD.dismiss()
        print("webview did fail load with error: \(error)")
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        print("URLRequest = \(shouldStartLoadWith)")
        
        if shouldStartLoadWith.url?.absoluteString == "http://smtgroup.in/miss_mauritius/payment/fail" {
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "TransactionStatusViewController") as! TransactionStatusViewController
            vc.strStatus = "fail"
            self.navigationController?.pushViewController(vc, animated: true)
        } else if shouldStartLoadWith.url?.absoluteString == "http://smtgroup.in/miss_mauritius/payment/success" {
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "TransactionStatusViewController") as! TransactionStatusViewController
            vc.strStatus = "success"
            vc.obPlan = obPlan
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return true
    }

}
