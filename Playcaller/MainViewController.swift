//
//  MainViewController.swift
//  Playcaller
//
//  Created by Kam Dahlin on 9/30/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        let buttonStackView = self.buttonStackView
        
        coordinator.animate(alongsideTransition: { (context) in
            if newCollection.verticalSizeClass == .compact {
                buttonStackView?.axis = .horizontal
                buttonStackView?.spacing = 16
                
            } else {
                buttonStackView?.axis = .vertical
                buttonStackView?.spacing = 40
            }
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: Actions
    @IBAction func newPlaysheet(_ sender: AnyObject) {
        // push a navigation event to the event distro
        print("--- call a navigation event for a new playsheet")
    }

    @IBAction func playbook(_ sender: AnyObject) {
        // push a navigation event to the event distro
        print("--- call a navigation event for the playbook feature")
    }
    

}

