//
//  ExerciseStatisticExerciseCollectionViewCell.swift
//  Push
//
//  Created by Patrick Niepel on 21.10.17.
//  Copyright © 2017 Patrick Niepel. All rights reserved.
//

import UIKit

class ExerciseStatisticExerciseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var exercise: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}