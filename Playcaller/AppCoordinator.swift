//
//  AppCoordinator.swift
//  Playcaller
//
//  Created by Kam Dahlin on 9/30/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//
import UIKit

class AppCoordinator<ManagedController: UIViewController> {
    let managedController: ManagedController
    
    private var hasProfile: Bool {
        // based on model lookup
        return true
    }
    
    init(withManagedController managedController: ManagedController) {
        self.managedController = managedController
    }

    func start() {
        if !self.hasProfile {
            
        }
    }
    
    func end() {
        // no-op for now
    }
    
// Mark: - Actions
    func showPlaybook() {
        
    }
    
    func newPlaysheet() {
        
    }
    
    func showProfile() {
        
    }
}
