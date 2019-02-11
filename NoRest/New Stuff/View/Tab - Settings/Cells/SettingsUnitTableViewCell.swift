//
//  SettingsUnitTableViewCell.swift
//  NoRest
//
//  Created by Patrick Niepel on 30.01.19.
//  Copyright © 2019 Patrick Niepel. All rights reserved.
//

import UIKit

class SettingsUnitTableViewCell: UITableViewCell {
    
    private lazy var unitSegmentedControl: UISegmentedControl = {
        let items: [String] = [Unit.kg.rawValue, Unit.lbs.rawValue]
        let control = UISegmentedControl(items: items)
        control.tintColor = .mainColor
        
        let segmentWidth = self.contentView.frame.width * 0.75 / 2
        for i in 0..<items.count {
            control.setWidth(segmentWidth, forSegmentAt: i)
        }
        
        control.selectedSegmentIndex = SettingsController.currentUnitAsIndex
        control.addTarget(self, action: #selector(unitChanged), for: .valueChanged)
        return control
    }()
    
    private let contentLabel: NRLabel = {
        let label = NRLabel(with: NRConstants.Settings.RowTitles.unit)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        self.selectionStyle = .none
        
        contentView.addSubview(contentLabel)
        contentView.addSubview(unitSegmentedControl)
        
        unitSegmentedControl.anchor(top: nil, leading: nil, bottom: nil, trailing: contentView.trailingAnchor, centerY: true, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .defaultPadding))
        
        contentLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: .leadingPaddingCell, bottom: 0, right: 0))
    }
    
    @objc private func unitChanged(sender: UISegmentedControl) {
        SettingsController.unitChanged(to: sender.selectedSegmentIndex)
    }

}
