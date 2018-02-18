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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        decodeData()
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
        encodeData()
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
                self.encodeData()
                self.tableView.reloadData()
            }
            print((addItemField?.text)!)
        }
        alert.addAction(action)
        alert.addTextField { (alertTextfiled) in
            alertTextfiled.placeholder = "Create New Item"
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK:- Encode
    
    func encodeData()  {
        
        let encoder = PropertyListEncoder()
        if let data = try?encoder.encode(self.itemArray)  {
            do{
                try data.write(to: self.dataFilePath!)
            }catch {
                print("Encode error \(error)")
            }
        }
    }
    
    //MARK:- Decode
    
    func decodeData()  {
        
        if let fileData = try? Data.init(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            
            do{
                itemArray = try decoder.decode([ItemModel].self, from: fileData)
            }
            catch {
                print("decode error \(error)")
            }
        }
    }
    
    
    
}

