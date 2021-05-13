//
//  TodoTableViewController.swift
//  Todo
//
//  Created by shunnamiki on 2021/05/12.
//

import UIKit

class TodoTableViewController: UITableViewController {
    private let cellId = "TodoCell"
    var list = [
        Todo(title: "buy a milk"),
        Todo(title: "buy a milk"),
        Todo(title: "buy a milk"),
        Todo(title: "buy a milk"),
        Todo(title: "buy a milk"),
    ]
    
//    var sections = [
//        "High",
//        "Middle",
//        "Low",
//    ]
    
    var deleteButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.title = "Delete"
        item.isEnabled = false
        return item
    }()
    
    @objc func gotoUpsertPage(){
        print("GO TO UPSERT PAGE")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        // table
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.allowsMultipleSelectionDuringEditing = true
        
        // Nav
        let insertButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(gotoUpsertPage))
        navigationItem.rightBarButtonItems = [insertButtonItem, deleteButtonItem]
        navigationItem.leftBarButtonItem = editButtonItem

        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
//        return sections.count
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodoTableViewCell
        cell.showsReorderControl = true
        let item = list[indexPath.row]
        cell.update(item: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !tableView.isEditing else { return }
        list[indexPath.row] = {
            var item = list[indexPath.row]
            item.isCompleted = !item.isCompleted
            return item
        }()

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - EDIT mode
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("OK")
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}
