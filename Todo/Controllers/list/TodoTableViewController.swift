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
        [
            Todo(title: "buy a sushi1", priority: 0),
            Todo(title: "buy a sushi1", priority: 0),
            Todo(title: "buy a sushi3", priority: 0),
            Todo(title: "buy a sushi4", priority: 0),
            Todo(title: "buy a sushi5", priority: 0),
        ],
        [
            Todo(title: "buy a egg1", priority: 1),
            Todo(title: "buy a egg2", priority: 1),
            Todo(title: "buy a egg3", priority: 1),
            Todo(title: "buy a egg4", priority: 1),
            Todo(title: "buy a egg5", priority: 1),
        ],
        [
            Todo(title: "buy a milk1", priority: 2),
            Todo(title: "buy a milk2", priority: 2),
            Todo(title: "buy a milk3", priority: 2),
            Todo(title: "buy a milk4", priority: 2),
            Todo(title: "buy a milk5", priority: 2),
        ],
    ]
    
    var sections = [
        "High",
        "Middle",
        "Low",
    ]
    
    var deleteButtonItem = UIBarButtonItem()
    var insertButtonItem = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodoTableViewCell
        cell.showsReorderControl = true
        cell.accessoryType = .detailDisclosureButton
        let item = list[indexPath.section][indexPath.row]
        cell.update(item: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }
    
    // MARK: - Toggle and select when to editingMode
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isEditing
            ? updateDeleteButtonItemEnable()
            : toggleRow(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard tableView.isEditing else { return }
        updateDeleteButtonItemEnable()
    }
    
    // MARK: - Move row position
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var moved = list[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        moved.priority = destinationIndexPath.section
        list[destinationIndexPath.section].insert(moved, at: destinationIndexPath.row)
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 40
//    }
    
    // MARK: - Goto Upsert page to update
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let item = list[indexPath.section][indexPath.row]
        
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

    // MARK: - PRIVATE FUNCITIONS
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
        list[indexPath.section].remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    private func toggleRow(indexPath: IndexPath){
        list[indexPath.section][indexPath.row] = {
            var item = list[indexPath.section][indexPath.row]
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
}

extension TodoTableViewController: UpsertTodoTableViewControllerDelegation {
    func update(_ todo: Todo) {
        guard let selectedIndexPath = selectedIndexPath else { return }
        list[selectedIndexPath.section][selectedIndexPath.row] = todo
        tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        self.selectedIndexPath = nil
    }
    
    func insert(_ todo: Todo) {
        let section = todo.priority
        list[section].append(todo)
        let indexPath = IndexPath(row: list[section].count - 1, section: section)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}
