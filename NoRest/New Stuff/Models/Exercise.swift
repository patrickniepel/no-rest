//
//  Exercise.swift
//  Push
//
//  Created by Patrick Niepel on 13.10.17.
//  Copyright © 2017 Patrick Niepel. All rights reserved.
//

import Foundation

struct Exercise: Codable, Equatable, Comparable {
    
    let id: Int
    var name: String
    private var restTimer: Int = 0 // - Seconds
    private var cardiotimer: Int = 0 // Cardio timer - Minutes
    var timer: Int {
        set(newValue) {
            if self.type == .weightLifting {
                restTimer = newValue
            } else {
                cardiotimer = newValue
            }
        }
        get {
            return self.type == .weightLifting ? restTimer : cardiotimer
        }
    }
    var notes: String
    
    let category: Category
    var type: ExerciseType
    var sets: [Set]
    
    init(name: String, category: Category, timer: Int = 90, notes: String = NRConstants.Editing.noNotes, type: ExerciseType = .weightLifting) {
        id = PersistencyController.currentExerciseID()
        self.name = name
        self.notes = notes
        self.category = category
        self.type = type
        self.sets = []
        self.timer = timer
    }
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.name < rhs.name
    }
}

enum ExerciseType: String, Codable {
    case weightLifting = "Weight Lifting"
    case cardio = "Cardio"
    
    static var allCases: [ExerciseType] = [.weightLifting, .cardio]
}