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
    
    init(title: String){
        self.title = title
    }
}
