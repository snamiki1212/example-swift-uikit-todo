//
//  UpsertTodoTableViewControllerDelegation.swift
//  Todo
//
//  Created by shunnamiki on 2021/05/12.
//

import Foundation

protocol UpsertTodoTableViewControllerDelegation {
    func insert(_ todo: Todo)
    func update(_ todo: Todo)
}
