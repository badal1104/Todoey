//
//  ViewController.swift
//  Todoey
//
//  Created by Badal Yadav on 17/02/18.
//  Copyright © 2018 badal. All rights reserved.
//

import UIKit
import CoreData
class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        loadData()
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
       // managedObjectContext.delete(modelData)
       // itemArray.remove(at: indexPath.row)
        saveContext()
        tableView.reloadData()
    }
    
    //MARK:- UiBarButton Action
    
    @IBAction func addButtonPressed(_ sender : UIBarButtonItem) {
        
        let alert = UIAlertController.init(title: "Add New Todo Item", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            let addItemField =  alert.textFields?.last
            
            if addItemField?.text != "" {
                let newItem = Item(context: self.managedObjectContext)
                newItem.title = addItemField?.text
                newItem.done = false
                self.itemArray.append(newItem)
                self.saveContext()
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
    
    //MARK:- Save Context
    
    func saveContext()  {
            do{
                  try managedObjectContext.save()
            }catch {
                print("core data save error \(error)")
            }
    }
    
    //MARK:- Load Context
    
    func loadData(with request : NSFetchRequest<Item> = Item.fetchRequest())  {
        //let fetchRequest : NSFetchRequest = Item.fetchRequest()
        if let data = try? managedObjectContext.fetch(request) {
            itemArray = data
            tableView.reloadData()
        }
    }
}

//MARK:- UISearchBar delegate
extension TodoListViewController : UISearchBarDelegate  {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let fetchRequest : NSFetchRequest = Item.fetchRequest()
        let predicate = NSPredicate.init(format:"title CONTAINS[cd] %@", searchBar.text!)
        fetchRequest.predicate = predicate
        let sortDesciptpr = NSSortDescriptor.init(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDesciptpr]
        loadData(with: fetchRequest)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
        
        
    }
    
}
