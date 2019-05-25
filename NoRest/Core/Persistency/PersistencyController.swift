//
//  PersistencyController.swift
//  NoRest
//
//  Created by Patrick Niepel on 30.01.19.
//  Copyright © 2019 Patrick Niepel. All rights reserved.
//

import Foundation

struct PersistencyController: Codable {
    
    static func loadUserData() {
        if let userData = FileController.loadData() {
            UserData.sharedInstance = userData
            let workout1 = MyWorkout(name: "Push", exercises: [])
            workout1.date = Date()
            
            let workout2 = MyWorkout(name: "Pull", exercises: [])
            workout2.date = Date()
            
            UserData.sharedInstance.workoutHistory.addWorkoutToHistory(workout1)
            UserData.sharedInstance.workoutHistory.addWorkoutToHistory(workout1)
            UserData.sharedInstance.workoutHistory.addWorkoutToHistory(workout1)
            UserData.sharedInstance.workoutHistory.addWorkoutToHistory(workout1)
            UserData.sharedInstance.workoutHistory.addWorkoutToHistory(workout1)
            UserData.sharedInstance.workoutHistory.addWorkoutToHistory(workout2)
        }
        
        if UserData.sharedInstance.exercises.isEmpty {
            UserData.sharedInstance.exercises = DefaultExercise.allExercises()
            storeUserData()
        }
    }
    
    static func storeUserData() {
        FileController.storeData(data: UserData.sharedInstance)
    }
    
    static func currentWorkoutID() -> Int {
        let id = UserDefaults.standard.integer(forKey: NRConstants.DataIdentifiers.currentWorkoutID) + 1
        storeCurrentWorkoutID(id)
        return id
    }
    
    private static func storeCurrentWorkoutID(_ id: Int) {
        UserDefaults.standard.set(id, forKey: NRConstants.DataIdentifiers.currentWorkoutID)
    }
    
    static func currentExerciseID() -> Int {
        let id = UserDefaults.standard.integer(forKey: NRConstants.DataIdentifiers.currentExerciseID) + 1
        storeCurrentExerciseID(id)
        return id
    }
    
    private static func storeCurrentExerciseID(_ id: Int) {
        UserDefaults.standard.set(id, forKey: NRConstants.DataIdentifiers.currentExerciseID)
    }
}