//
//  ViewController.swift
//  Todoey
//
//  Created by macbookpro on 16/9/18.
//  Copyright © 2018 macbookpro. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController : UITableViewController {

    var toDoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //prints container location
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        
    }
    //MARK - Tableview Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row] {
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        }else {
        cell.textLabel?.text = "Click plus symbol to add items"
        }
        return cell
    }
    //MARK - Tableview delegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if let item = toDoItems?[indexPath.row]{
        do {
            try realm.write {
                //realm.delete(item) - Deletes item when selected
                item.done = !item.done
            }
        } catch  {
            print("Error saving done status\(error)")
        }
           tableView.reloadData()
        }

        tableView.deselectRow(at: indexPath, animated: true)
     
    }
    //MARK - Add new items section
    
  
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when user clicks the add item button on UIView
        
            if let currentCategory = self.selectedCategory {
                do {
                try self.realm.write {
                    let newItem = Item()
                newItem.title = textField.text!
                currentCategory.items.append(newItem)
                    }
                    
                }catch {
                    print("Error saving category \(error)")
                }
            }
            self.tableView.reloadData()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }

        func loadItems() {
            
            toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
            
            tableView.reloadData()
    }


    //MARK - Model Manupulation Methods
   


 
//       let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        }
//       let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//
//        request.predicate = compoundPredicate
//
//        do {
//         itemArray = try context.fetch(request)
//        }catch {
//            print("Error fetching data from context \(error)")
//
    
    
    
//MARK - Search Bar Methods

//extension TodoListViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
//
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//
//        }
//    }
//}
}





















