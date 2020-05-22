//
//  StatsHeaderView.swift
//  NoRest
//
//  Created by Patrick Niepel on 24.05.19.
//  Copyright © 2019 Patrick Niepel. All rights reserved.
//

import UIKit

class StatsHeaderView: UICollectionReusableView {
    
    private let titleLabel: NRLabel = {
        let label = NRLabel()
        label.textColor = NRStyle.complementaryColor
        label.font = UIFont(name: NRStyle.boldFont, size: 30)
        return label
    }()
    
    func setup(with title: String) {
        titleLabel.text = title
        addSubview(titleLabel)
        titleLabel.fillSuperview(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 16))
        
        backgroundColor = NRStyle.themeColor
    }
}
