//
//  TodoTableViewController.swift
//  Todo
//
//  Created by shunnamiki on 2021/05/12.
//

import UIKit

class TodoTableViewController: UITableViewController {
    private let cellId = "TodoCell"
    var selectedIndexPath: IndexPath?
    var list = [
        Todo(title: "buy a milk1"),
        Todo(title: "buy a milk2"),
        Todo(title: "buy a milk3"),
        Todo(title: "buy a milk4"),
        Todo(title: "buy a milk5"),
    ]
    
//    var sections = [
//        "High",
//        "Middle",
//        "Low",
//    ]
    
    var deleteButtonItem = UIBarButtonItem()
    var insertButtonItem = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        // table
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.allowsMultipleSelectionDuringEditing = true
        
        // Nav
        insertButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(gotoUpsertPage))
        deleteButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteSelectedRows))
        deleteButtonItem.isEnabled = false
        
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
        cell.accessoryType = .detailDisclosureButton
        let item = list[indexPath.row]
        cell.update(item: item)
        return cell
    }
    
    // MARK: - Toggle and select when to editingMode
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("THIS IS SELECT")
        if tableView.isEditing {
            updateDeleteButtonItemEnable()
        } else {
            toggleRow(indexPath: indexPath)
        }
    }
    
    private func toggleRow(indexPath: IndexPath){
        list[indexPath.row] = {
            var item = list[indexPath.row]
            item.isCompleted = !item.isCompleted
            return item
        }()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func updateDeleteButtonItemEnable(){
        let canDelete: Bool = {
            if let _ = tableView.indexPathsForSelectedRows {
                return true
            } else {
                return false
            }
        }()
        deleteButtonItem.isEnabled = canDelete
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard tableView.isEditing else { return }
        updateDeleteButtonItemEnable()
    }
    
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 40
//    }
    
    // MARK: - Goto Upsert page to update
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let item = list[indexPath.row]
        
        // TODO: functionrize
        let vc = UpsertTodoTableViewController()
        vc.delegation = self
        vc.todo = item
        let uiNavController = UINavigationController(rootViewController: vc)
        present(uiNavController, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Delete to swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteItem(indexPath: indexPath)
    }
    
    // MARK: - Disable delete button after editing
    override func setEditing(_ editing: Bool, animated: Bool) {
        if !editing {
            deleteButtonItem.isEnabled = false
        }
        super.setEditing(editing, animated: animated)
    }

    @objc private func gotoUpsertPage(){
        let vc = UpsertTodoTableViewController()
        vc.delegation = self
        let uiNavController = UINavigationController(rootViewController: vc)
        present(uiNavController, animated: true, completion: nil)
    }
    
    @objc private func deleteSelectedRows(){
        guard let selectedIndexPaths = tableView.indexPathsForSelectedRows else { return }
        
        // NOTE: sort desc because of becoming removable
        let sortedIndexPaths = selectedIndexPaths.sorted { item1, item2 in
            item1.section != item2.section ? item1.section > item2.section : item1.row > item2.row
        }

        for indexPath in sortedIndexPaths {
            deleteItem(indexPath: IndexPath(row: indexPath.row, section: indexPath.section))
        }
        
        updateDeleteButtonItemEnable()
    }
    
    private func deleteItem(indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

extension TodoTableViewController: UpsertTodoTableViewControllerDelegation {
    func update(_ todo: Todo) {
        guard let selectedIndexPath = selectedIndexPath else { return }
        list[selectedIndexPath.row] = todo
        tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        self.selectedIndexPath = nil
    }
    
    func insert(_ todo: Todo) {
        list.append(todo)
        let indexPath = IndexPath(row: list.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}
