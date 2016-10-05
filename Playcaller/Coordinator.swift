//
//  Coordinator.swift
//  Playcaller
//
//  Created by Kam Dahlin on 10/3/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import UIKit


protocol Coordinator: class {
    weak var parent: Coordinator? { get set }
    var children: [Coordinator] { get set }
    
    var currentCoordinator: Coordinator? { get }
    
    weak var managedController: UIViewController? { get }
    init(with managedController: UIViewController)
    
    func start()
    func end()
    
    // optional
    func push(coordinator: Coordinator)
    @discardableResult func pop() -> Coordinator?
}

extension Coordinator {
    
    func push(coordinator: Coordinator) {
        self.children.append(coordinator)
        coordinator.parent = self
    }
    
    @discardableResult func pop() -> Coordinator? {
        guard let last = self.children.popLast() else {
            return nil
        }
        last.parent = nil
        return last
    }
    
    var currentCoordinator: Coordinator? {
        return self.children.last
    }
}
