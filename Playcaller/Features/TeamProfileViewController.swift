//
//  TeamProfileViewController.swift
//  Playcaller
//
//  Created by Kam Dahlin on 10/1/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import UIKit

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
        //self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func save(_ sender: AnyObject) {
        print("---- send save event")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
