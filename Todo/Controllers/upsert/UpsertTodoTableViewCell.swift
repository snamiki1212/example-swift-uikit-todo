//
//  UpsertTodoTableViewCell.swift
//  Todo
//
//  Created by shunnamiki on 2021/05/12.
//

import UIKit

class UpsertTodoTableViewCell: UITableViewCell {
    public var field : UITextField = {
        let field = UITextField()
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        print("UPSERT TODO TABLE VIEW CELL")
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Layout
        field.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(field)
        field.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        field.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        field.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        field.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
