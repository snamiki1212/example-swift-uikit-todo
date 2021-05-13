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
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    var checkLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        let stack = UIStackView(arrangedSubviews: [checkLabel, titleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stack)
        stack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.backgroundColor = .red
        print("THIS IS INIT")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func renderCheckLabel(isCompleted: Bool) -> String {
        return isCompleted ? "✅" : "☑️"
    }
    
    func update(item: Todo) {
        titleLabel.text = item.title
        checkLabel.text = renderCheckLabel(isCompleted: item.isCompleted)
    }
    

}