//
//  ViewController.swift
//  SwiftlyDublinToDo
//
//  Created by Ciaran O hUallachain on 29/10/2014.
//  Copyright (c) 2014 Ciaran O hUallachain. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var toDoItems = [ToDoEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadToDoItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoCell") as UITableViewCell
        let toDoItem = toDoItems[indexPath.row]
        cell.textLabel.text = toDoItem.toDoTitle
        cell.accessoryType = toDoItem.complete.boolValue ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row.description)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func loadToDoItems() {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        let entityName: NSString = "ToDoEntity"
        
        var error: NSError? = nil
        var fetchRequest: NSFetchRequest = NSFetchRequest(entityName: entityName)
        fetchRequest.resultType = NSFetchRequestResultType.ManagedObjectResultType
        let results: NSArray = context.executeFetchRequest(fetchRequest, error:  &error)!
        
        toDoItems = [ToDoEntity]()
        for data in results {
            var toDoEntity = data as ToDoEntity
            toDoItems.append(toDoEntity)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let toDoController: ToDoViewController = segue.destinationViewController as ToDoViewController
        if (segue.identifier == "EditToDo") {
            let cell = sender as UITableViewCell
            let tableView = self.view as UITableView
            let index = tableView.indexPathForCell(cell)! as NSIndexPath
            let toDoEntity = self.toDoItems[index.row] as ToDoEntity
            
            toDoController.toDoEntity = toDoEntity
        }
        toDoController.toDoDelegate = self
    }
    
    override func reloadInputViews() {
        loadToDoItems()
        tableView.reloadData()
        super.reloadInputViews()
    }
}

