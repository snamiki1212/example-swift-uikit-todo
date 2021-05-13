//
//  UpsertTodoTableViewController.swift
//  Todo
//
//  Created by shunnamiki on 2021/05/12.
//

import UIKit

class UpsertTodoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("UPSERT TODO TABLE VIEW Controller")
    }
    
    var delegation: UpsertTodoTableViewControllerDelegation?

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UpsertTodoTableViewCell {

        let cell = UpsertTodoTableViewCell()
        
        switch indexPath {
        case [0, 0]:
            cell.field.text = "THIS IS EDITABLE"
            return cell
        default:
            return cell
        }
    }

}

