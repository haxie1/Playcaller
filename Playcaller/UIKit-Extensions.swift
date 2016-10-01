//
//  UIKit-Extensions.swift
//  Playcaller
//
//  Created by Kam Dahlin on 9/30/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import UIKit

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
}

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
