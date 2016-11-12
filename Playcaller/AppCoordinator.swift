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
    case show(feature: AppFeature)
    // other events
    
    var eventData: NavEvent {
        return self
    }
}

// TODO: Decide how to handle routing between features of teh application using nav events.

enum AppFeature: String {
    case home
    case settings
    case playbook
    case playsheet
}

class AppCoordinator: Coordinator {
    weak var parent: Coordinator?
    var children: [Coordinator] = []
    
    private (set) weak var managedController: UIViewController?
    private var eventDistributerID: UUID?
    private var playbookModel: PlaycallerModel
    
    required init(with managedController: UIViewController) {
        self.managedController = managedController
        self.playbookModel = PlaycallerModel()
        
        self.eventDistributerID = EventDistributer.shared.register(handler: self)
        self.playbookModel.load { (error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func start() {
        if !self.hasProfile() {
            // post this after a delay in order to provide a bit of context to the user.
            //
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
        let storyboard = UIStoryboard(name: "Playsheet", bundle: nil)
        guard let playsheetController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't create the playsheet controller")
        }
        
        self.managedController?.present(playsheetController, animated: true, completion: nil)
        
    }
    
    private func hasProfile() -> Bool {
        if let profile: TeamProfile = self.playbookModel.fetchFirst(TeamProfile.fetchRequest()) {
            return profile.name != nil
        }
        
        return false
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
        case .show(let feature):
            print("coordinator will show \(feature)")
            self.show(feature: feature)
            break
        }
    }
    
    func show(feature: AppFeature) {
        switch feature {
        case .home:
            break
        case .playbook:
            self.showPlaybook()
            break
        case .playsheet:
            self.newPlaysheet()
            break
        case .settings:
            self.showTeamProfile()
            break
        }
    }
}
