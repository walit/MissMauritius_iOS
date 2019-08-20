//
//  ContestantCell.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 19/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit
import SDWebImage

protocol ContestantDelegate {
    func voteForContestant(index: Int)
    func likeContestant(index: Int)
}

class ContestantCell: UICollectionViewCell {
    
    //@IBOutlet weak var imgHeightConstraint: NSLayoutConstraint!
    var delegate: ContestantDelegate?
    var index = Int()
    
    @IBAction func btn_Like(_ sender: Any) {
        delegate?.likeContestant(index: index)
    }
    @IBOutlet weak var btn_Like: UIButton!
    @IBOutlet weak var btn_Vote: UIButton!
    @IBAction func btn_Vote(_ sender: Any) {
        delegate?.voteForContestant(index: index)
    }
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var imgView_User: UIImageView!
    
    func setImageSize() {
        if ScreenSize.SCREEN_WIDTH == 414 {
            //imgView_User.
        }
    }
    
    func setContestantData(obCont: ContestantModel?) {
        lbl_Name.text = obCont?.fullName
        imgView_User.sd_setImage(with: URL(string: obCont!.image!), placeholderImage: UIImage.init(named: "img_user"))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if self.imgView_User.image != nil {
                self.imgView_User.image = MF.cropBottomImage(image: self.imgView_User.image!)
            }
            
        }
        
        
        if obCont?.isVote == 1 {
            btn_Like.setImage(UIImage(named: "thumb_fill_icon"), for: UIControl.State.normal)
        } else {
            btn_Like.setImage(UIImage(named: "thumb_icon"), for: UIControl.State.normal)
        }
        
    }
    
}
