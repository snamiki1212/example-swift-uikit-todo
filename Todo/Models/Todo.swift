//
//  Todo.swift
//  Todo
//
//  Created by shunnamiki on 2021/05/12.
//

import Foundation

struct Todo {
    var title: String
    var isCompleted: Bool = false
    var priority: Int = 0
    
    init(title: String, priority: Int = 0){
        self.title = title
        self.priority = priority
    }
}
