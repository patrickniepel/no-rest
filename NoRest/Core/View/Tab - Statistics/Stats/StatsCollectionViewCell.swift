//
//  StatsCollectionViewCell.swift
//  NoRest
//
//  Created by Patrick Niepel on 11.02.19.
//  Copyright © 2019 Patrick Niepel. All rights reserved.
//

import UIKit

class StatsCollectionViewCell: UICollectionViewCell {
    
    let statsTitleLabel: NRLabel = {
        let label = NRLabel(with: "")
        label.textColor = .textColor
        label.makeBold()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let statsValueLabel: NRLabel = {
        let label = NRLabel(with: "")
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: NRConstants.Font.fontBold, size: .fontSizeLarge)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(with stat: Stat) {
        statsTitleLabel.text = stat.title.rawValue
        statsValueLabel.text = "\(stat.value) \(SettingsController.currentUnit.rawValue)"
        
        setupDesign()
        setupLayout()
    }
    
    private func setupDesign() {
        contentView.backgroundColor = .backgroundColorUIControl
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        applyShadow()
    }
    
    private func setupLayout() {
        contentView.addSubviews(statsTitleLabel, statsValueLabel)
        
        statsTitleLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: contentView.bounds.height * 0.33))
        
        statsValueLabel.anchor(top: statsTitleLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
    }
}