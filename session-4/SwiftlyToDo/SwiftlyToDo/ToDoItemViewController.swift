//
//  ToDoItemViewController.swift
//  SwiftlyToDo
//
//  Created by Ciaran O hUallachain on 29/10/2014.
//  Copyright (c) 2014 Ciaran O hUallachain. All rights reserved.
//

import UIKit

class ToDoItemViewController: UIViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var statusSwitch: UISwitch!
    @IBOutlet var descriptionTextView: UITextView!
    
    var toDoItem: ToDoItem? = nil
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
        if let item: ToDoItem = self.toDoItem {
            self.titleTextField.text = item.titleText
            self.descriptionTextView.text = item.descriptionText
            self.statusSwitch.on = item.complete.boolValue
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
        
        if ((self.toDoItem) == nil) {
            self.toDoItem = ToDoItem()
        }
        
        self.toDoItem?.titleText = titleText
        self.toDoItem?.descriptionText = self.descriptionTextView.text
        self.toDoItem?.complete = self.statusSwitch.on
        
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
