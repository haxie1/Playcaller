//
//  TeamProfile+CoreDataProperties.swift
//  Playcaller
//
//  Created by Kam Dahlin on 10/9/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import Foundation
import CoreData


extension TeamProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamProfile> {
        return NSFetchRequest<TeamProfile>(entityName: "TeamProfile");
    }

    @NSManaged public var name: String?

}
