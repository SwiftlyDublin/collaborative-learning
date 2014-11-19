//
//  ToDoEntity.swift
//  SwiftlyDublinToDo
//
//  Created by Ciaran O hUallachain on 29/10/2014.
//  Copyright (c) 2014 Ciaran O hUallachain. All rights reserved.
//

import Foundation
import CoreData

class ToDoEntity: NSManagedObject {

    @NSManaged var toDoDescription: String
    @NSManaged var toDoTitle: String
    @NSManaged var complete: NSNumber

}
