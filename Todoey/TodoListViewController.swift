//
//  ViewController.swift
//  Todoey
//
//  Created by Badal Yadav on 17/02/18.
//  Copyright © 2018 badal. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["1","2","3"]
    let user_Default = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        if let userDeffaultArray = user_Default.value(forKey: "ToDoListArray") {
            itemArray = userDeffaultArray as! Array
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK:- UITableViewDelegates & DataSources
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel!.text = itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
        }
        else {
            cell?.accessoryType = .checkmark
        }
    }
    
    //MARK:- UiBarButton Action
    
    @IBAction func addButtonPressed(_ sender : UIBarButtonItem) {
        
        let alert = UIAlertController.init(title: "Add New Todo Item", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            let addItemField =  alert.textFields?.last
            if addItemField?.text != "" {
                self.itemArray.append((addItemField?.text)!)
                self.tableView.reloadData()
                
                self.user_Default.set(self.itemArray, forKey: "ToDoListArray")
                
            }
            print((addItemField?.text)!)

          
        }
        alert.addAction(action)
        alert.addTextField { (alertTextfiled) in
            alertTextfiled.placeholder = "Create New Item"
        }
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
}

