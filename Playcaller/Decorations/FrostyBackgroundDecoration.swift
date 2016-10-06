//
//  FrostyBackgroundDecoration.swift
//  Playcaller
//
//  Created by Kam Dahlin on 10/5/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import UIKit
@IBDesignable class FrostyImageView: UIView {
    var imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        
        self.imageView.addSubview(blurView)
        self.imageView.alpha = 0.8
        
        self.addSubview(self.imageView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.widthAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 1).isActive = true
        blurView.heightAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 1).isActive = true
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        self.imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
    }
}

class FrostyBackgroundDecoration: NSObject {
    @IBOutlet weak var targetVC: UIViewController! {
        didSet {
            print("---------- set the targetVC on the decoration")
        }
    }
    
    @IBInspectable var backgroundImage: UIImage?
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
        self.frostyView.imageView.image = self.backgroundImage
    }
}
