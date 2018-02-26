//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Badal Yadav on 25/02/18.
//  Copyright © 2018 badal. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let managedObjectContect = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadData()
    }
    
    //MARK: - BarButton Action - Add
    
    @IBAction func addCategoryItem(_ sender : UIBarButtonItem){
        
        let alertView = UIAlertController.init(title: "Add New Category", message: nil, preferredStyle: .alert)
        alertView.addTextField { (textfield) in
            textfield.placeholder = "Add new category"
        }
        let alertAction = UIAlertAction.init(title: "OK", style: .default) { (alertAction) in
            
            let alertTextField = alertView.textFields?.last
            
            if let checkText = alertTextField?.text {
                
                let context = Category(context: self.managedObjectContect)
                context.name = checkText
                self.categoryArray.append(context)
                self.saveData()
            }
        }
        alertView.addAction(alertAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source & delegates
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! TodoListViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            destination.selectedCategory = categoryArray[selectedIndexPath.row]
        }
    }
    
    
    //MARK: - Save and Load Data from CoreData
    
    func loadData(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        
        if let fetchDataArray = try? managedObjectContect.fetch(request) {
            
            if fetchDataArray.count > 0 {
                categoryArray = fetchDataArray
                tableView.reloadData()
            }
        }
    }
    
    func saveData(){
        do {
            try managedObjectContect.save()
            tableView.reloadData()
        }
        catch {
            print("save error \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
