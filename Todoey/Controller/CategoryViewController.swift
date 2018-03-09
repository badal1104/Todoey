//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Badal Yadav on 05/03/18.
//  Copyright © 2018 badal. All rights reserved.
//

import UIKit
import RealmSwift
class CategoryViewController: UITableViewController {

    var categories:Results<Category>?
    
    var realm:Realm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            realm = try Realm()
        }
        catch{
            print("realm \(error)")
        }
        loadCategory()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source and Delegates

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories?[indexPath.row]
        cell.textLabel?.text = category?.name ?? "No category added yet"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToItems" {
            let todoViewController = segue.destination as! TodoListViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                todoViewController.selectedCategory = categories?[indexPath.row]
            }
            
        }
        
        
    }

    @IBAction func addCategoriesMethod(){
        
        let categoryAlert = UIAlertController.init(title: nil, message: "Add New Category", preferredStyle: .alert)
        categoryAlert.addTextField { (textfield) in
            textfield.placeholder = "Create New Category"
        }
        let alertAction = UIAlertAction.init(title: "Add", style: .default) {[unowned self] (action) in
            
            let alertTextfield = categoryAlert.textFields!.last!
            if alertTextfield.text != "" {
 
                let newCategory = Category()
                newCategory.name = alertTextfield.text!
                self.saveCategory(addCategory: newCategory)
            }
        }
        categoryAlert.addAction(alertAction)
        self.present(categoryAlert, animated: true, completion: nil)
    }
    
    func saveCategory(addCategory: Category) {
        
        do{
          try realm?.write {
                realm!.add(addCategory)
                self.tableView.reloadData()
            }
        }
        catch {
            print("realm saving error = \(error)")
        }
    }
   
    func loadCategory() {
        
      categories = realm?.objects(Category.self)
        
    }

}
