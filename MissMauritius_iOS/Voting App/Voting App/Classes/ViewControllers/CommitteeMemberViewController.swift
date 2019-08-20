//
//  CommitteeMemberViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 14/08/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class CommitteeMemberViewController: UIViewController {
    
    var arrCommittee:[CommitteeModel]? = [CommitteeModel]()
    
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.rowHeight = 210.0
        tblView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        arrCommittee = [CommitteeModel]()
        getCommitteeMemberList()
    }
    
    func getCommitteeMemberList() {
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.Common.Committeelist, methodType: 2, forContent: 3, OnView: self, withParameters: NSMutableDictionary()) { (dictJson, status) in
            if status == 1 {
                
                if let arr = dictJson["data"] as? NSArray {
                    for i in 0..<arr.count {
                        let obCom:CommitteeModel? = CommitteeModel()
                        obCom?.initWith(dict: arr[i] as? NSDictionary)
                        self.arrCommittee?.append(obCom!)
                    }
                }
                self.tblView.reloadData()
            }
        }
    }

}

extension CommitteeMemberViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCommittee!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommitteeCell", for: indexPath) as! CommitteeCell
        // cell.intIndex = indexPath.row
        // cell.delegate = self
        cell.setCommitteeData(obCom: arrCommittee?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
