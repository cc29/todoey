//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Chetan Chauhan on 12/08/19.
//  Copyright © 2019 Chetan Chauhan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
  let defaulfs = UserDefaults.standard
  var itemArray = [Item]()
   let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //print(dataFilePath)
        
        
//        let newItem = Item()
//        newItem.title = "find mike"
//        itemArray.append(newItem)
//        
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggs"
//        itemArray.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.title = "Distroy Demogogen"
//        itemArray.append(newItem3)

        loadItems()
        
        
        //        if let items = defaulfs.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
//        }
        
    }
    //MARK - Table view Data sorce Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       print("reusable cell loading")
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType =  item.done ? .checkmark : .none
        return cell
    }
    
    
    //MARK - Table View Delegete Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
           tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new Section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on our UIAlert
            //print("success!")
            //print(textField.text)
           let newItem = Item()
            self.itemArray.append(newItem)
            newItem.title = textField.text!
            self.saveItems()
          
        }
     
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    
    //Mark - Model Manupulation Methods
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error uncoding item array,\(error))")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding itemArray")
            }
        }
    }
    
}

