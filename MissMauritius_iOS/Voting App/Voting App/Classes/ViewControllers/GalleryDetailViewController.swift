//
//  GalleryDetailViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 16/08/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class GalleryDetailViewController: UIViewController {

    
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var pageCtrl: UIPageControl!
    @IBAction func pageCtrl(_ sender: Any) {
    }
    @IBOutlet weak var colView: UICollectionView!
    var arrGallery = NSArray()
    var intContestantId = Int()
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getContestantDetails()
    }
    
    func getContestantDetails() {
                self.colView.reloadData()
                self.slidingGalleryView()
                self.pageCtrl.numberOfPages = self.arrGallery.count
        }
    
    func slidingGalleryView() {
        
        self.colView.reloadData()
        
        // Invalidating timer for safety reasons
        self.timer.invalidate()
        
        // Below, for each 3.5 seconds MyViewController's 'autoScrollImageSlider' would be fired
        self.timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.autoScrollImageSlider), userInfo: nil, repeats: true)
        
        //This will register the timer to the main run loop
        RunLoop.main.add(self.timer, forMode: .common)
        
    }
    
    @objc func autoScrollImageSlider() {
        
        DispatchQueue.global(qos: .background).async {
            
            DispatchQueue.main.async {
                
                let firstIndex = 0
                let lastIndex = self.arrGallery.count - 1
                
                let visibleIndices = self.colView.indexPathsForVisibleItems
                let nextIndex = visibleIndices[0].row + 1
                
                let nextIndexPath: IndexPath = IndexPath.init(item: nextIndex, section: 0)
                let firstIndexPath: IndexPath = IndexPath.init(item: firstIndex, section: 0)
                
                if nextIndex > lastIndex {
                    self.pageCtrl.currentPage = firstIndex
                    self.colView.scrollToItem(at: firstIndexPath, at: .centeredHorizontally, animated: true)
                } else {
                    self.pageCtrl.currentPage = nextIndex
                    self.colView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                }
            }
        }
    
    }
}
    // MARK: - Navigation
extension GalleryDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenSize.SCREEN_WIDTH , height: ScreenSize.SCREEN_WIDTH)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrGallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCell
        cell.setUserImage(imgUrl: arrGallery[indexPath.row] as! String)
        return cell
    }
}


