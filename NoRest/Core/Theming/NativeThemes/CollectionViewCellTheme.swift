//
//  CollectionViewCellTheme.swift
//  NoRest
//
//  Created by Patrick Niepel on 22.06.20.
//  Copyright © 2020 Patrick Niepel. All rights reserved.
//

import Gestalt
import UIKit

struct CollectionViewCellTheme: Theme {
    let textColor: UIColor
    let backgroundColor: UIColor
    let offWhiteColor: UIColor
    let accentuationColor: UIColor

    let textFont: UIFont

    init(palette: Palette) {
        textColor = palette.colors.dynamic.primaryText
        backgroundColor = palette.colors.dynamic.theme
        offWhiteColor = palette.colors.static.offWhite
        accentuationColor = palette.colors.static.accentuation

        textFont = palette.fonts.static.regular()
    }
}
