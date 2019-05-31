//
//  HistoryCollectionViewCell.swift
//  NoRest
//
//  Created by Patrick Niepel on 28.02.19.
//  Copyright © 2019 Patrick Niepel. All rights reserved.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    
    private let dateLabel: NRLabel = {
        let label = NRLabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(date: Date?) {
        layer.cornerRadius = 20
        backgroundColor = .backgroundColorUIControl
        applyShadow()
        
        guard let date = date else { return }
        dateLabel.text = "\(date)"
        setupLabelLayout()
    }
    
    private func setupLabelLayout() {
        addSubview(dateLabel)
        dateLabel.fillSuperview()
    }
}
