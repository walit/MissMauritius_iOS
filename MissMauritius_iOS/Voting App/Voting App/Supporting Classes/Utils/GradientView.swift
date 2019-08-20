//
//  GradientView.swift
//  ZBRS
//
//  Created by Piotr Marnik on 01/02/2017.
//  Copyright © 2017 Zofly AB. All rights reserved.
//

import UIKit

class GradientView: BaseView {
    
    private let gradientLayer: CAGradientLayer
    private let fromColor: UIColor
    private let toColor: UIColor
    
    init(frame: CGRect, fromColor: UIColor, toColor: UIColor) {
        self.fromColor = fromColor
        self.toColor = toColor
        gradientLayer = CAGradientLayer()
       
        gradientLayer.colors = [fromColor.cgColor, toColor.cgColor]
        super.init(frame: frame)
        gradientLayer.frame = bounds
    }
    
    override func setupViews() {
       
        layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        didSet {
            //super.frame = frame
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            gradientLayer.frame = bounds
            CATransaction.commit()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
