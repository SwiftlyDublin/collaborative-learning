//
//  ToDoItemViewController.swift
//  SwiftlyToDo
//
//  Created by Ciaran O hUallachain on 29/10/2014.
//  Copyright (c) 2014 Ciaran O hUallachain. All rights reserved.
//

import UIKit
import CoreData

class ToDoItemViewController: UIViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var statusSwitch: UISwitch!
    @IBOutlet var descriptionTextView: UITextView!
    
    var toDoItem: ToDoEntity? = nil
    var toDoSaveDelegate: ToDoViewControllerDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if let item: ToDoEntity = self.toDoItem {
            self.titleTextField.text = item.toDoTitle
            self.descriptionTextView.text = item.toDoDescription
            self.statusSwitch.on = item.toDoComplete as Bool
        } else {
            self.statusSwitch.on = false
        }
        super.viewWillAppear(animated)
    }
    
    @IBAction func save() {
        let titleText: NSString = self.titleTextField.text
        if (titleText.length == 0) {
            return
        }
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        if ((self.toDoItem) == nil) {
            self.toDoItem = (NSEntityDescription.insertNewObjectForEntityForName("ToDoEntity", inManagedObjectContext:
            context) as ToDoEntity)
        }
        
        self.toDoItem?.toDoTitle = titleText
        self.toDoItem?.toDoDescription = self.descriptionTextView.text
        self.toDoItem?.toDoComplete = self.statusSwitch.on
        
        self.toDoSaveDelegate?.saveToDoItem(self.toDoItem!)
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
