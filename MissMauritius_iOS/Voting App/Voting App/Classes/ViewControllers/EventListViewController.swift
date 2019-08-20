//
//  EventListViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 25/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var arrEventList:[EventModel]? = [EventModel]()
    
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.rowHeight = 210.0
        tblView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getEventList()
    }
   
    // MARK: - Navigation

    func getEventList() {
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.Events.List, methodType: 2, forContent: 3, OnView: self, withParameters: NSMutableDictionary()) { (dictJson, status) in
            if status == 1 {
                for i in 0..<(dictJson["data"] as! NSArray).count {
                    let obEve:EventModel? = EventModel()
                    obEve?.initWith(dict: (dictJson["data"] as! NSArray)[i] as? NSDictionary)
                    self.arrEventList?.append(obEve!)
                }
                self.tblView.reloadData()
            }
        }
    }
    
}

extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEventList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
       // cell.intIndex = indexPath.row
       // cell.delegate = self
        cell.setEventData(obEve: arrEventList?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}
