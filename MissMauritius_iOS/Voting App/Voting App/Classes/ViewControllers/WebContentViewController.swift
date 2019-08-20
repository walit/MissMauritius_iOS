//
//  WebContentViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 02/07/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit
import SVProgressHUD
class WebContentViewController: UIViewController {

    var strLink = String()
    var strType = String()
    @IBOutlet weak var webView_Content: UIWebView!
    @IBOutlet weak var lbl_Title: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbl_Title.text = strType
        let request = NSMutableURLRequest(url: URL(string: strLink)!)
         webView_Content.loadRequest(request as URLRequest)
        webView_Content.frame = self.view.bounds
        webView_Content.scalesPageToFit = true
    }
    
    @IBAction func btn_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

extension WebContentViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView){
        SVProgressHUD.show(withStatus: NSLocalizedString("loading...", comment: ""))
           print("webViewDidStartLoad")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
        print("webViewDidFinishLoad")
    }
    
    func webView(_webView: UIWebView, didFailLoadWithError error: NSError) {
        SVProgressHUD.dismiss()
        print("webview did fail load with error: \(error)")
    }
    
}
