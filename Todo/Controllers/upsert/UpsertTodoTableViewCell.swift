//
//  UpsertTodoTableViewCell.swift
//  Todo
//
//  Created by shunnamiki on 2021/05/12.
//

import UIKit

// TODO: RENAME title 
class UpsertTodoTableViewCell: UITableViewCell {
    public var field : UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Layout
        field.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(field)
        field.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        field.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        field.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        field.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
