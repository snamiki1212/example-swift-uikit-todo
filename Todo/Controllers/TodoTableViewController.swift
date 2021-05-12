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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: cellId)
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
        cell.textLabel?.text = item.title
//        cell.update(item: item)
        return cell
    }
}
