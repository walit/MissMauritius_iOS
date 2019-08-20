//
//  SponsorListViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 28/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class SponsorListViewController: UIViewController {

    @IBOutlet weak var colView: UICollectionView!
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
}

extension SponsorListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (ScreenSize.SCREEN_WIDTH ) / 2, height: (ScreenSize.SCREEN_WIDTH ) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SponsorCell", for: indexPath) as! SponsorCell
        if indexPath.row != 4 {
            cell.imgView.image = UIImage(named: "\(indexPath.row + 1)")
        } else {
            
            cell.imgView.image = UIImage.gif(name: "51")
            cell.imgView.contentMode = .scaleAspectFit
            cell.imgView.backgroundColor = UIColor.white
           // let jeremyGif = UIImage.gifImageWithName("51")
           // cell.imgView =  UIImageView(image: jeremyGif)
        } 
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
