//
//  ToDoEntity.swift
//  SwiftlyToDo
//
//  Created by Ciaran O hUallachain on 19/11/2014.
//  Copyright (c) 2014 Ciaran O hUallachain. All rights reserved.
//

import Foundation
import CoreData

class ToDoEntity: NSManagedObject {

    @NSManaged var toDoTitle: String
    @NSManaged var toDoDescription: String
    @NSManaged var toDoComplete: NSNumber

}
