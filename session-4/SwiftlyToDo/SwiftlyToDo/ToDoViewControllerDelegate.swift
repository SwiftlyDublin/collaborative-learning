//
//  ToDoViewControllerDelegate.swift
//  SwiftlyToDo
//
//  Created by Ciaran O hUallachain on 19/11/2014.
//  Copyright (c) 2014 Ciaran O hUallachain. All rights reserved.
//

import Foundation

protocol ToDoViewControllerDelegate {
    func saveToDoItem(toDoItem: ToDoItem);
}
