//
//  ViewController.swift
//  Todoey
//
//  Created by Badal Yadav on 17/02/18.
//  Copyright © 2018 badal. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [ItemModel]()
    let user_Default = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        
        let firstObject = ItemModel.init(titleString: "One", doneFlag: false)
        let secondObject = ItemModel.init(titleString: "Two", doneFlag: false)
        let thirdObject = ItemModel.init(titleString: "Three", doneFlag: false)
        let fourthObject = ItemModel.init(titleString: "4", doneFlag: false)
        let fiftheObject = ItemModel.init(titleString: "5", doneFlag: false)
        let sixthObject = ItemModel.init(titleString: "6", doneFlag: false)
        let seventhObject = ItemModel.init(titleString: "7", doneFlag: false)
        let eightObject = ItemModel.init(titleString: "8", doneFlag: false)
        let ninthObject = ItemModel.init(titleString: "9", doneFlag: false)
        let tenthObject = ItemModel.init(titleString: "10", doneFlag: false)
        let eleventhdObject = ItemModel.init(titleString: "11", doneFlag: false)
        let twelvethObject = ItemModel.init(titleString: "12", doneFlag: false)
        let thirteenObject = ItemModel.init(titleString: "13", doneFlag: false)
        let fouteenObject = ItemModel.init(titleString: "14", doneFlag: false)
        let fifteenObject = ItemModel.init(titleString: "15", doneFlag: false)
        let sixteenObject = ItemModel.init(titleString: "16", doneFlag: false)
        let seventeenObject = ItemModel.init(titleString: "17", doneFlag: false)
        let eighteenObject = ItemModel.init(titleString: "18", doneFlag: false)
        let ninteenObject = ItemModel.init(titleString: "19", doneFlag: false)
        let twentyObject = ItemModel.init(titleString: "20", doneFlag: false)


        itemArray.append(firstObject)
        itemArray.append(secondObject)
        itemArray.append(thirdObject)
        itemArray.append(fourthObject)
        itemArray.append(fiftheObject)
        itemArray.append(sixthObject)
        itemArray.append(seventhObject)
        itemArray.append(eightObject)
        itemArray.append(ninthObject)
        itemArray.append(tenthObject)
        itemArray.append(eleventhdObject)
        itemArray.append(twelvethObject)
        itemArray.append(thirteenObject)
        itemArray.append(fouteenObject)
        itemArray.append(fifteenObject)
        itemArray.append(sixteenObject)
        itemArray.append(seventeenObject)
        itemArray.append(eighteenObject)
        itemArray.append(ninteenObject)
        itemArray.append(twentyObject)



        
        
        
        if let userDeffaultArray = user_Default.value(forKey: "ToDoListArray") {
            itemArray = userDeffaultArray as! Array
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK:- UITableViewDelegates & DataSources
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let modelData = itemArray[indexPath.row]
        cell.textLabel!.text = modelData.title
        
        cell.accessoryType = modelData.done ? .checkmark : .none
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let modelData = itemArray[indexPath.row]
        modelData.done = !modelData.done
        tableView.reloadData()
    }
    
    //MARK:- UiBarButton Action
    
    @IBAction func addButtonPressed(_ sender : UIBarButtonItem) {
        
        let alert = UIAlertController.init(title: "Add New Todo Item", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            let addItemField =  alert.textFields?.last
            if addItemField?.text != "" {
                
                let addItem = ItemModel.init(titleString: (addItemField?.text)!, doneFlag: false)
                self.itemArray.append(addItem)
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

