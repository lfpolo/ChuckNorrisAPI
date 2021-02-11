//
//  EventTableViewCell.swift
//  TesteIOS
//
//  Created by Levy Cristian on 23/10/20.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
}

extension CategoryTableViewCell: CodeView {
    func buildViewHierarchy() {}
    
    func setupConstraints() {}
    
    func setupAdditionalConfig() {
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
        self.backgroundColor = .backgroundColor
        self.textLabel?.textColor = .textColor
    }
}
