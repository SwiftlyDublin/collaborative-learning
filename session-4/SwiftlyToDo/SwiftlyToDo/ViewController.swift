//
//  ViewController.swift
//  SwiftlyToDo
//
//  Created by Ciaran O hUallachain on 29/10/2014.
//  Copyright (c) 2014 Ciaran O hUallachain. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController, ToDoViewControllerDelegate {
    var toDoItems: [ToDoEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.toDoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoCell") as UITableViewCell
        let toDoItem = self.toDoItems[indexPath.row]
        cell.textLabel.text = toDoItem.toDoTitle
        cell.accessoryType = toDoItem.toDoComplete as Bool ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.description)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func saveToDoItem(toDoItem: ToDoEntity) {
        let testItems = NSSet(array: self.toDoItems)
        if (!testItems.containsObject(toDoItem)) {
            self.toDoItems.append(toDoItem)
        }
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var error: NSError? = nil
        var success = context.save(&error)
        
        if (success) {
            self.tableView.reloadData()
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let toDoController: ToDoItemViewController = segue.destinationViewController as ToDoItemViewController
        if (segue.identifier == "ShowToDoItem") {
            let cell = sender as UITableViewCell
            let tableView = self.view as UITableView
            let indexPath = tableView.indexPathForCell(cell)! as NSIndexPath
            let toDoItem = self.toDoItems[indexPath.row]
            
            toDoController.toDoItem = toDoItem
        }
        toDoController.toDoSaveDelegate = self
    }
}

