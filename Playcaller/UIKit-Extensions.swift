//
//  UIKit-Extensions.swift
//  Playcaller
//
//  Created by Kam Dahlin on 9/30/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import UIKit

// expose controls in Interface Builder to style UIViews.
extension UIView {
    @IBInspectable var borderColor: UIColor {
        set (color) {
            self.layer.borderColor = color.cgColor
        }
        get {
            let color = self.layer.borderColor ?? UIColor.clear.cgColor
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var bordered: Bool {
        set (isBordered) {
            if isBordered {
                self.layer.borderColor = self.borderColor.cgColor
                self.layer.borderWidth = 2.0
                self.layer.cornerRadius = 6.0
                self.layer.setValue(true, forKey: "bordered")
            } else {
                self.layer.borderColor = UIColor.clear.cgColor
                self.layer.setValue(false, forKey: "bordered")
            }
        }
        get {
            return self.layer.value(forKey: "bordered") as? Bool ?? false
        }
    }
    
    @IBInspectable var bottomShadow: Bool {
        set (shadow) {
            let layer = self.layer
            if shadow {
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
                layer.shadowRadius = 1.0
                layer.shadowOpacity = 0.3
                self.clipsToBounds = false
            } else {
                layer.shadowOpacity = 0.0
                self.clipsToBounds = true
            }
        }
        get {
            return self.layer.shadowOpacity > 0.0
        }
    }
}

// Expose a switch in Interface Builder to toggle transparent navigation bars.
extension UINavigationBar {
    @IBInspectable var transparent: Bool {
        set (isTransparent) {
            self.isTranslucent = isTransparent
            self.setBackgroundImage(UIImage(), for: .default)
            self.shadowImage = UIImage()
        }
        
        get {
            return self.isTranslucent
        }
    }
}
