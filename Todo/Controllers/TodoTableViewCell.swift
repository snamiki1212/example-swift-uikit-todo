//
//  TodoTableViewCell.swift
//  Todo
//
//  Created by shunnamiki on 2021/05/12.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "DEFAULT"
        label.backgroundColor = .yellow
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let stack = UIStackView(arrangedSubviews: [titleLabel])
        stack.axis = .horizontal
        stack.backgroundColor = .red
        print("THIS IS INIT")
        contentView.addSubview(stack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(item: Todo) {
        titleLabel.text = item.title
    }
}
