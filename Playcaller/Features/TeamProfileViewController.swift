//
//  TeamProfileViewController.swift
//  Playcaller
//
//  Created by Kam Dahlin on 10/1/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import UIKit
import Events

class TeamProfileViewController: UIViewController {
    @IBOutlet var decoration: FrostyBackgroundDecoration! {
        didSet {
            print("set the decoration on the view")
        }
    }
    
    @IBOutlet weak var teamNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        print("---- send cancel event")
        EventDistributer.shared.distribute(event: NavEvent.dismiss)
    }

    @IBAction func save(_ sender: AnyObject) {
        print("---- send save event")
        EventDistributer.shared.distribute(event: NavEvent.dismiss)
    }
}
