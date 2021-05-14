//
//  UpsertTodoTableViewController.swift
//  Todo
//
//  Created by shunnamiki on 2021/05/12.
//

import UIKit

class UpsertTodoTableViewController: UITableViewController {

    var todo: Todo?
    var titleCell = UpsertTodoTableViewTitleCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Nav
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(doDismiss))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        
        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.separatorStyle = .none
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UpsertTodoTableViewTitleCell {

        switch indexPath {
        case [0, 0]:
            if let title = todo?.title {
                titleCell.field.text = title
            }
            return titleCell
        default:
            fatalError("Unexpeced Error")
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Title"
        default:
            fatalError("Unexpeced Error")
        }
    }
    
    @objc private func doDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func save(){
        let newTodo = Todo(title: titleCell.field.text ?? "")
        let isUpdating = self.todo != nil
        isUpdating
            ? delegation!.update(newTodo)
            : delegation!.insert(newTodo)
        doDismiss()
    }

}
