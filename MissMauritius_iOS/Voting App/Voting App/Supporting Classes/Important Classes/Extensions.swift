//
//  Extensions.swift
//  Coconut Co
//
//  Created by Gourav Joshi on 03/10/17.
//  Copyright © 2017 Gourav Joshi. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit

extension URL {
    var isHidden: Bool {
        get {
            return (try? resourceValues(forKeys: [.isHiddenKey]))?.isHidden == true
        }
        set {
            var resourceValues = URLResourceValues()
            resourceValues.isHidden = newValue
            do {
                try setResourceValues(resourceValues)
            } catch {
                print("isHidden error:", error)
            }
        }
    }
}

extension DesignableLabel {
    @IBInspectable
    var leftTextInset: CGFloat {
        set { textInsets.left = newValue }
        get { return textInsets.left }
    }
    
    @IBInspectable
    var rightTextInset: CGFloat {
        set { textInsets.right = newValue }
        get { return textInsets.right }
    }
    
    @IBInspectable
    var topTextInset: CGFloat {
        set { textInsets.top = newValue }
        get { return textInsets.top }
    }
    
    @IBInspectable
    var bottomTextInset: CGFloat {
        set { textInsets.bottom = newValue }
        get { return textInsets.bottom }
    }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}

extension Bool {
    func intValue() -> Int {
        if self {
            return 1
        }
        return 0
    }
    
    func int32Value() -> Int32 {
        if self {
            return 1
        }
        return 0
    }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

extension UIButton {
    
    func addRightImage(image: UIImage, offset: CGFloat) {
            self.setImage(image, for: .normal)
            self.imageView?.translatesAutoresizingMaskIntoConstraints = false
            self.imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
            self.imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -offset).isActive = true
    }
    
    func underlineButton(text: String) {
        let titleString = NSMutableAttributedString(string: text)
        titleString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, text.count))
        
        titleString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSMakeRange(0, text.count))
        titleString.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.blue, range: NSMakeRange(0, text.count))
        self.setAttributedTitle(titleString, for: .normal)
    }
    
    func addBottomBorderWithColor(color: UIColor, height: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - height, width: self.frame.size.width, height: height)
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func setDifferentColor(string: String, location: Int, length: Int) {
        
        let attText = NSMutableAttributedString(string: string)
        attText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: string.count))
        attText.addAttribute(NSAttributedString.Key.foregroundColor, value: CustomColors.themeColorYellow, range: NSRange(location:location,length:length))
        self.setAttributedTitle(attText, for: .normal)
    }
    
}

extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

extension UITextField {
    
    func setUnderlineColor(color: UIColor?) {
        let border = CALayer()
        border.backgroundColor = color!.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UITextView {
    func addBottomBorderWithColor(color: UIColor, height: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - height, width: self.frame.size.width, height: height)
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension Character {
    var asciiValue: Int {
        get {
            let s = String(self).unicodeScalars
            return Int(s[s.startIndex].value)
        }
    }
}

extension UIImageView {
    func changeImageColor( color:UIColor) -> UIImage
    {
        image = image!.withRenderingMode(.alwaysTemplate)
        tintColor = color
        return image!
    }
    
    func getImageSize() -> CGRect {
       
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }
        
        print("image.size.width = \(image.size.width), image.size.height = \(image.size.height)")
        
        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }
        
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
        
    }
}

extension String {
    
    func strikeThrough()->NSAttributedString{
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    var length1: Int {
        return self.count
    }
    
    func toInt() -> Int? {
        return Int.init(self)
    }
  
    /**
     Encode a String to Base64
     :returns:
     */
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func toFloat() -> Float? {
        return Float.init(self)
    }
    
    func toDouble() -> Double? {
        return Double.init(self)
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    /*
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    func substring(from: Int) -> String {
        return self[Range(min(from, length1) ..< length1)]
    }
    
    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    } */
    /*
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length1, r.lowerBound)),
                                            upper: min(length1, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[Range(start ..< end)])
    } */
    
    
}

extension UILabel {
    func setDifferentColor(string: String, location: Int, length: Int){
        
        let attText = NSMutableAttributedString(string: string)
        attText.addAttribute(NSAttributedString.Key.foregroundColor, value: CustomColors.themeColorYellow, range: NSRange(location:location,length:length))
        attributedText = attText
        
    }
}

extension UIViewController {

    func makeScene() -> SKScene {
        
        let scene = SKScene.init(size: CGSize(width:view.frame.width-50,height:view.frame.height-50))
        scene.backgroundColor = .black
        return scene
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let  touch = touches.first
//        firstPoint = touch!.locationInNode(self)
    }
    
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!;
    }
    
    func getClassName() -> String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!;
    }

    func executeUIProcess(_ block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }

    func showAlertViewWithMessage(_ strMessage: String, vc: UIViewController){
        MF.ShowPopUpViewOn(viewController: vc, popUpType: PopUpType.Simple, message: strMessage)
    }
    
    func showAlertViewWithDuration(_ strMessage: String, vc: UIViewController)  {
        let alert = UIAlertController(title: "", message: strMessage, preferredStyle: UIAlertController.Style.alert)
//        let messageFont = [NSAttributedString.Key.font: UIFont(name: CustomFont.themeFont, size: 16.0)!]
//        let messageAttrString = NSMutableAttributedString(string: strMessage, attributes: messageFont)
//        alert.setValue(messageAttrString, forKey: "attributedMessage")

        //alert.view.backgroundColor = CustomColors.themeColorYellow
        vc.present(alert, animated: true, completion: nil)
        let delay = 2.5 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
                 alert.dismiss(animated: true, completion: nil)
        })
        //MF.ShowPopUpViewOn(viewController: vc, popUpType: PopUpType.Toast, title: "", message: strMessage)
    }
   
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case least = 0.0
        case lowest  = 0.2
        case low     = 0.4
        case medium  = 0.5
        case high    = 0.6
        case highest = 0.8
        case peak = 1.0
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func imageQuality(_ quality: JPEGQuality) -> Data? {
        
        return self.jpegData(compressionQuality: quality.rawValue)
    }
    
    func image(with color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context!.setBlendMode(.normal)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context?.clip(to: rect, mask: cgImage!)
        color1.setFill()
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func resizeByByte(maxByte: Int, completion: @escaping (Data) -> Void) {
        var compressQuality: CGFloat = 1
        var imageData = Data()
        var imageByte = self.jpegData(compressionQuality: 1)?.count
        
        print("imageData = \(imageData.count)")
        
        while imageByte! > maxByte {
            imageData = self.jpegData(compressionQuality: compressQuality)!
            imageByte = self.jpegData(compressionQuality: compressQuality)?.count
            //compressQuality -= 0.1
        }
        
        if maxByte > imageByte! {
            print("imageData1 = \(imageData.count)")
            completion(imageData)
        } else {
            completion(self.jpegData(compressionQuality: 1)!)
        }
    }
}


extension UIView {
    
    func roundCornersWithLayerMask(cornerRadii: CGFloat, corners: UIRectCorner, borderColor: UIColor) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 1.0
        layer.mask = maskLayer
    }
    
        /// Adds bottom border to the view with given side margins
        ///
        /// - Parameters:
        ///   - color: the border color
        ///   - margins: the left and right margin
        ///   - borderLineSize: the size of the border
        func addBottomBorder(color: UIColor = UIColor.red, margins: CGFloat = 0, borderLineSize: CGFloat = 1) {
            let border = UIView()
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(border)
            border.addConstraint(NSLayoutConstraint(item: border,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .height,
                                                    multiplier: 1, constant: borderLineSize))
            self.addConstraint(NSLayoutConstraint(item: border,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .bottom,
                                                  multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: border,
                                                  attribute: .leading,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .leading,
                                                  multiplier: 1, constant: margins))
            self.addConstraint(NSLayoutConstraint(item: border,
                                                  attribute: .trailing,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .trailing,
                                                  multiplier: 1, constant: margins))
        }
    
    public func removeAllSubViews() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
    func takeScreenshot() -> UIImage {
        
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (image != nil)
        {
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
            return image!
        }
        return UIImage()
    }
    
}

extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}
extension Date {
    
    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear, .weekOfMonth], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}

extension UIColor {
    convenience init(hex:Int, alpha:CGFloat = 1.0) {
        self.init(
            red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat((hex & 0x0000FF) >> 0)  / 255.0,
            alpha: alpha
        )
    }
}
