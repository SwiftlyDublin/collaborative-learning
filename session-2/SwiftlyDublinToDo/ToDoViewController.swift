//
//  ToDoViewController.swift
//  SwiftlyDublinToDo
//
//  Created by Ciaran O hUallachain on 29/10/2014.
//  Copyright (c) 2014 Ciaran O hUallachain. All rights reserved.
//

import UIKit
import CoreData

class ToDoViewController: UIViewController {
    var toDoEntity: ToDoEntity? = nil
    var toDoDelegate: ViewController? = nil
    @IBOutlet var toDoTitleTextField : UITextField!
    @IBOutlet var toDoDescriptionTextView : UITextView!
    @IBOutlet var toDoStatusSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if let entity: ToDoEntity = self.toDoEntity {
            self.toDoTitleTextField.text = entity.toDoTitle
            self.toDoDescriptionTextView.text = entity.toDoDescription
            self.toDoStatusSwitch.on = entity.complete.boolValue
        } else {
            self.toDoStatusSwitch.on = false
        }
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save() {
        println("saving")
        let titleText: NSString = self.toDoTitleTextField.text
        if (titleText.length == 0) {
            return
        }
        
        if (!updateItem()) {
            saveNewItem()
        }
        if let delegate = self.toDoDelegate {
            toDoDelegate?.reloadInputViews()
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func saveNewItem() -> Bool {
        var success = true
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        let entityName: NSString = "ToDoEntity"
        var toDoItem: ToDoEntity! = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: context) as ToDoEntity
        toDoItem.toDoTitle = self.toDoTitleTextField.text
        toDoItem.toDoDescription = self.toDoDescriptionTextView.text
        toDoItem.complete = self.toDoStatusSwitch.on
        var error: NSError? = nil
        if (!context.save(&error)) {
            println(error)
            success = false
        }
        return success
    }
    
    func updateItem() -> Bool {
        var success = false
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        if let toDoItem = self.toDoEntity {
            toDoItem.toDoTitle = self.toDoTitleTextField.text
            toDoItem.toDoDescription = self.toDoDescriptionTextView.text
            toDoItem.complete = self.toDoStatusSwitch.on
            var error: NSError? = nil
            if (!context.save(&error)) {
                println(error)
            } else {
                success = true
            }
        }
        return success
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
