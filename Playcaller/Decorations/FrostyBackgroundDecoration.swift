//
//  FrostyBackgroundDecoration.swift
//  Playcaller
//
//  Created by Kam Dahlin on 10/5/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import UIKit
@IBDesignable class FrostyImageView: UIView {
    
}

class FrostyBackgroundDecoration: NSObject {
    @IBOutlet weak var targetVC: UIViewController! {
        didSet {
            print("---------- set the targetVC on the decoration")
        }
    }
    
    @IBInspectable var backgroundImage: UIImage? {
        didSet {
            print("----- set the image on the background image")
        }
    }
    
    var frostyView: FrostyImageView = FrostyImageView()
   
    override func awakeFromNib() {
        super.awakeFromNib()
        //
      
        self.targetVC.view.insertSubview(self.frostyView, at: 0)
        self.setupFrostyView()
    }

    private func setupFrostyView() {
        self.frostyView.translatesAutoresizingMaskIntoConstraints = false
        self.frostyView.topAnchor.constraint(equalTo: self.targetVC.view.topAnchor).isActive = true
        self.frostyView.bottomAnchor.constraint(equalTo: self.targetVC.view.bottomAnchor).isActive = true
        self.frostyView.leadingAnchor.constraint(equalTo: self.targetVC.view.leadingAnchor).isActive = true
        self.frostyView.trailingAnchor.constraint(equalTo: self.targetVC.view.trailingAnchor).isActive = true
        self.frostyView.backgroundColor = UIColor.black
        let imageView = UIImageView(image: self.backgroundImage)
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        imageView.addSubview(blurView)
        imageView.alpha = 0.8
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.frostyView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: self.frostyView.widthAnchor, multiplier: 1).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.frostyView.heightAnchor, multiplier: 1).isActive = true
        blurView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
        blurView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1).isActive = true
    }
}
