//
//  EventModel.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 25/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class EventModel: NSObject {
    var eventId:Int? = Int()
    var eventImage:String? = String()
    var eventDate:String? = String()
    var eventTime:String? = String()
    var eventTitle:String? = String()
    
    override init() { }
    
    func initWith(dict: NSDictionary?) {
        self.eventImage = dict?["event_image"] as? String
        self.eventTitle = dict?["event_title"] as? String
        self.eventDate = dict?["event_date"] as? String
        self.eventTime = dict?["event_time"] as? String
    }
    
}
