//
//  AppCoordinator.swift
//  Playcaller
//
//  Created by Kam Dahlin on 9/30/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//
import UIKit
import Events

enum NavEvent: Event {
    case dismiss
    case push
    case pop
    // other events
    
    var eventData: NavEvent {
        return self
    }
}

class AppCoordinator: Coordinator {
    weak var parent: Coordinator?
    var children: [Coordinator] = []
    
    private (set) weak var managedController: UIViewController?
    private var eventDistributerID: UUID?
    
    required init(with managedController: UIViewController) {
        self.managedController = managedController
        self.eventDistributerID = EventDistributer.shared.register(handler: self)
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

extension AppCoordinator: EventHandler {
    func handle<T: Event>(event: T) {
        if let navEvent = event as? NavEvent {
            self.handle(nav: navEvent)
        }
    }
    
    func handle(nav: NavEvent) {
        switch nav.eventData {
        case .dismiss:
            self.managedController?.dismiss(animated: true, completion: nil)
            break
        case .pop:
            break
        case .push:
            break
        }
    }
}
