//
//  SectionTableViewCell.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 3/9/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit

class SectionTableViewCell: UITableViewCell {

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show all", for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(item: SectionItem) {
        categoryLabel.text = item.label
    }

}

// MARK: - UI
extension SectionTableViewCell {
    func makeUI() {
        contentView.addSubview(categoryLabel)
        contentView.addSubview(nextButton)
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.left.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-10)
            $0.right.equalTo(nextButton.snp.right)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalTo(60)
        }
        
    }
}
