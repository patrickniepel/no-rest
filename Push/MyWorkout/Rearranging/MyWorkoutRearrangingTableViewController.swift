//
//  MyWorkoutRearrangingTableViewController.swift
//  Push
//
//  Created by Patrick Niepel on 15.10.17.
//  Copyright © 2017 Patrick Niepel. All rights reserved.
//

import UIKit

protocol RearrangingSegueDelegate {
    func saveFromRearrangingScreen(ctrl: MyWorkoutRearrangingTableViewController, myWorkout: MyWorkout)
}

class MyWorkoutRearrangingTableViewController: UITableViewController {
    
    var dataSource : RearrangingDataSource!
    var delegateTV : RearrangingDelegate!
    
    var delegate : RearrangingSegueDelegate? = nil
    
    var myWorkoutToRearrange : MyWorkout!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = RearrangingDataSource()
        delegateTV = RearrangingDelegate()
        
        dataSource.workout = myWorkoutToRearrange
        
        self.navigationItem.title = myWorkoutToRearrange.name
        
        tableView.dataSource = dataSource
        tableView.delegate = delegateTV
        tableView.isEditing = true
    }
    
    @IBAction func saveWorkout(_ sender: UIBarButtonItem) {
        
        let workoutToSave = dataSource.workout
        delegate!.saveFromRearrangingScreen(ctrl: self, myWorkout: workoutToSave)
    }
}
