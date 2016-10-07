//
//  EventDistributer.swift
//  Playcaller
//
//  Created by Kam Dahlin on 10/5/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import Foundation

public protocol Event {
    associatedtype EventData
    var eventData: EventData { get }
}

// TODO: Move away from using an EventHandler type and instead of the EventDistributer register handlers directly. This will allow any type to register a handler and get events without a EventHandler conformance requirement.
// 
public protocol EventHandler {
    func handle<T: Event>(event: T)
}

public class EventDistributer {
    public static let shared = EventDistributer()
    
    private typealias EventRegistryItem = (id: UUID, item: RegistryItem)
    private var registry: [EventRegistryItem] = []
    
    public var registryCount: Int {
        return self.registry.count
    }
    
    @discardableResult public func register<T: EventHandler>(handler: T) -> UUID where T: AnyObject {
        let uuid = UUID()
        self.registry.append((id: uuid, item: RegistryItem(with: handler)))
        return uuid
    }
    
    public func unregister(with token: UUID) {
        guard let index = self.registry.index(where: { $0.id == token }) else {
            return
        }
        
        self.registry.remove(at: index)
    }
    
    public func unregisterAll() {
        self.registry = []
    }
    
    public func distribute<T: Event>(event: T) {
        var staleUUIDs = [UUID]()
        
        self.registry.forEach { (eventRegItem) in
            let registryItem = eventRegItem.item
            if let handler = registryItem.item as? EventHandler {
                handler.handle(event: event)
            } else {
                // the EventHandler no longer exists, so we need to remove this entry from the registry.
                staleUUIDs.append(eventRegItem.id)
            }
        }
        
        staleUUIDs.forEach { (uuid) in
            self.unregister(with: uuid)
        }
    }
    
    private class RegistryItem {
        weak var item: AnyObject?
        init(with item: AnyObject) {
            self.item = item
        }
    }
}
