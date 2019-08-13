//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Chetan Chauhan on 12/08/19.
//  Copyright © 2019 Chetan Chauhan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

  let itemArray = ["find mike", "Buy Eggs", "Destroy Demogogans"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK - Table view Data sorce Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    
    //MARK - Table View Delegete Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
           tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    

}

