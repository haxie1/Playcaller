// Example of a REgistry system that registers closures in a way that detects if the closure owner goes away.

import UIKit

protocol Event {
    associatedtype EventData
    var eventData: EventData { get }
}

typealias EventHandler<T: Event> = (T) -> Void?

class Registry {
    static let shared = Registry()
    var store: [(id: UUID, handler: WeakHandler)] = []
    
    class WeakHandler {
        var handler: AnyObject?
        var eventType: Any
        init(_ handler: AnyObject, eventType: Any) {
            self.handler = handler
            self.eventType = eventType
        }
    }
    
    func register<T: Event>(_ handler: @escaping EventHandler<T>) {
        let aHandler = WeakHandler(handler as AnyObject, eventType: T.self)
        let item = (id: UUID(), handler: aHandler)
        self.store.append(item)
    }
    
    func unregister(token: UUID) {
        guard let index = self.store.index(where: { $0.id == token }) else {
            return
        }
        
        self.store.remove(at: index)
    }
    
    func distribute<T: Event>(event: T) {
        print("distribute event: \(type(of: event))")
        var cleanup: [UUID] = []
        self.store.forEach { (storeItem) in
            let weakItem = storeItem.handler
            
            if let handler = weakItem.handler as? EventHandler<T> {
                let result: Void? = handler(event)
                if result == nil {
                   print("--- stale handler \(storeItem.id)")
                    cleanup.append(storeItem.id)
                }
            }
        }
        
        print("need to clean up items: \(cleanup.count)")
        cleanup.forEach { self.unregister(token: $0) }
    }
}

enum MyEvent: Event {
    case a
    case b
    var eventData: MyEvent {
        return self
    }
}

struct StructEvent: Event {
    var item: String = "Foo"
    var eventData: String {
        return item
    }
}

class MyHandler {
    init() {
        Registry.shared.register { [weak self] (event: MyEvent) in
            self?.myEvent(event: event)
        }
        
        Registry.shared.register { [weak self] (event: StructEvent) in
            self?.structEvent(event: event)
        }

    }
    
    func myEvent(event: MyEvent) {
        print("------ my event handler is called  with: \(event)")
    }
    
    func structEvent(event: StructEvent) {
        print("------ struct event handler called with: \(event)")
    }
    
    deinit {
        print("MyHandler is being released")
    }
}

var handler: MyHandler? = MyHandler()

let reg = Registry.shared
reg.distribute(event: MyEvent.a)
//handler = nil
reg.distribute(event: StructEvent())
handler = nil
print("=== post myhandler relase")
reg.distribute(event: MyEvent.a)
