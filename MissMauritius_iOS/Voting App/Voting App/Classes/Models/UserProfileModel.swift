//
//  UserProfileModel.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 21/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class UserProfileModel: NSObject {
    var firstName:String? = String()
    var lastName:String? = String()
    var phone:String? = String()
    var userId:Int? = Int()
    var imgUrl:String? = String()
    var email:String? = String()
    
    override init() { }
    
    func initWith(dict: NSDictionary?) {
        self.firstName = dict?["first_name"] as? String
        self.lastName = dict?["last_name"] as? String
        self.phone = dict?["phone"] as? String
        self.email = dict?["email"] as? String
        self.imgUrl = dict?["image"] as? String
        if let intUId = dict?["user_id"] as? Int {
            self.userId = intUId
        } else if let strUserId = dict?["user_id"] as? String {
            self.userId = Int(strUserId)
        }
    }
    
    private static var userProfile: UserProfileModel?
    
    class func sharedInstance() -> UserProfileModel {
        if self.userProfile == nil {
            self.userProfile = UserProfileModel()
            // Here user profile data will be inserted.
        } else {
            print("user object not nil")
        }
        return self.userProfile!
    }
    
}
