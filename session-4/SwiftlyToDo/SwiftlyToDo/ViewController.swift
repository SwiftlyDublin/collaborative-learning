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
    @IBOutlet var editButton: UIBarButtonItem! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadToDoData()
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
            self.loadToDoData()
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
    
    @IBAction func editTable(sender: UIBarButtonItem) {
        self.setEditing(!self.tableView.editing, animated: true)
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        self.editButton.title = editing ? "Done" : "Edit"
        super.setEditing(editing, animated: animated)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let toDoItem = self.toDoItems[indexPath.row]
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
            context.deleteObject(toDoItem)
            
            var error: NSError? = nil
            var success = context.save(&error)
            
            if (success) {
                self.loadToDoData()
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            }
        }
    }
    
    func loadToDoData() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var error: NSError? = nil
        var fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "ToDoEntity")
        fetchRequest.resultType = NSFetchRequestResultType.ManagedObjectResultType
        let results: NSArray = context.executeFetchRequest(fetchRequest, error:  &error)!
        
        self.toDoItems = [ToDoEntity]()
        for data in results {
            var toDoEntity = data as ToDoEntity
            self.toDoItems.append(toDoEntity)
        }
    }
}

