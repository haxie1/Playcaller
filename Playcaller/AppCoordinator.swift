//
//  AppCoordinator.swift
//  Playcaller
//
//  Created by Kam Dahlin on 9/30/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//
import UIKit

class AppCoordinator: Coordinator {
    weak var parent: Coordinator?
    var children: [Coordinator] = []
    
    private (set) weak var managedController: UIViewController?
    
    required init(with managedController: UIViewController) {
        self.managedController = managedController
    }
    
    func start() {
        if !self.hasProfile() {
           DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                self.showTeamProfile()
            }
        }
    }
    
    func end() {
    }

    func showTeamProfile() {
        let storyBoard = UIStoryboard(name: "TeamProfile", bundle: nil)
        guard let profileController = storyBoard.instantiateInitialViewController()  else {
            fatalError("Couldn't create the TeamProfile controller")
        }
        
        self.managedController?.present(profileController, animated: true, completion: nil)
    }
    
    func showPlaybook() {
        
    }
    
    func newPlaysheet() {
        
    }
    
    private func hasProfile() -> Bool {
        guard let _ = UserDefaults.standard.string(forKey: "TeamProfileName") else {
            return false
        }
        
        return true
    }
}
