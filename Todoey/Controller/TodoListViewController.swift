//
//  ViewController.swift
//  Todoey
//
//  Created by Badal Yadav on 17/02/18.
//  Copyright © 2018 badal. All rights reserved.
//

import UIKit
import RealmSwift
class TodoListViewController: UITableViewController {
    
    var toDoListItem: Results<Item>?
    var realm = try? Realm()
    
    var selectedCategory: Category? {
        didSet{
            loadData()
        }
    }
    let user_Default = UserDefaults.standard    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK:- UITableViewDelegates & DataSources
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let itemData = toDoListItem?[indexPath.row] {
            cell.textLabel!.text = itemData.title
            cell.accessoryType = itemData.done ? .checkmark : .none
        }
        else{
            cell.textLabel!.text = "No item addded yet"
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoListItem?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if  let itemData = toDoListItem?[indexPath.row]{
            do{
                try realm?.write {
                    itemData.done = !itemData.done //Update properties in Realm by writing under Write Commond
                    // realm.delete(itemData) // Delete object from Realm
                    tableView.reloadData()
                }
            }catch{
                print("error while saving Item\(error)")
                
            }
        }
    }
    
    //MARK:- UiBarButton Action
    
    @IBAction func addButtonPressed(_ sender : UIBarButtonItem) {
        
        let alert = UIAlertController.init(title: "Add New Todo Item", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "Add Item", style: .default) {[unowned self] (action) in
            let addItemField =  alert.textFields?.last
            
            if addItemField?.text != "" {
                
                if let currentCategory = self.selectedCategory{
                    
                    let itemObject = Item()
                    itemObject.title = addItemField!.text!

                    do {
                        try self.realm?.write {
                            currentCategory.items.append(itemObject)
                        }
                    }catch{
                        print("error while saving Item\(error)")
                    }
                }
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
    
    //MARK:- LoadData
    
    func loadData()  {
        toDoListItem = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true);
        tableView.reloadData()
    }
    
}

extension TodoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toDoListItem = toDoListItem?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0{
            loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        
    }
    
}

