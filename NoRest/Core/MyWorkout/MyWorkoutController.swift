//
//  MyWorkoutController.swift
//  NoRest
//
//  Created by Patrick Niepel on 16.02.19.
//  Copyright © 2019 Patrick Niepel. All rights reserved.
//

import Foundation

struct MyWorkoutController {
    
    func saveWorkout(_ workout: MyWorkout) {
        UpdateController.updateWorkout(workout)
    }
    
    func addWorkoutToHistory(_ workout: MyWorkout) {
        UpdateController.addWorkoutToHistory(workout)
    }
    
    func deleteWorkout(_ workout: MyWorkout) {
        UpdateController.deleteWorkout(workout)
    }
    
    func workoutCount() -> Int {
        return UserData.sharedInstance.myWorkouts.count
    }
    
    func allWorkouts() -> [MyWorkout] {
        return UserData.sharedInstance.myWorkouts.sorted()
    }
    
    func dateAsString(for date: Date?) -> String {
        if let date = date {
            return Date.withFormat(date: date, format: NRConstants.Date.defaultFormat)
        }
        return NRConstants.Date.workoutNotStarted
    }
    
    func loadWorkout(with id: Int?) -> MyWorkout? {
        guard let id = id else { return nil }
        return UserData.sharedInstance.myWorkouts.first(where: { $0.id == id })
    }
}