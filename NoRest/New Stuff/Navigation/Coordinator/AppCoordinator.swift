//
//  AppCoordinator.swift
//  Push
//
//  Created by Patrick Niepel on 21.01.19.
//  Copyright © 2019 Patrick Niepel. All rights reserved.
//

import UIKit

class AppCoordinator {
    var tabBarController: MainTabBarController?
    var myWorkoutNavigationController: UINavigationController?
    var exercisesNavigationController: UINavigationController?
    var statisticsNavigationController: UINavigationController?
    var settingsNavigationController: UINavigationController?
    
    var state: NavigationState?
    
    init() {
        setupInitialViewControllers()
        subscribe()
    }
    
    func setupInitialViewControllers() {
        let tabBarController = MainTabBarController()
        
        let myWorkout = ViewBuilder.buildMyWorkoutScreen()
        let myWorkoutNavigationController = buildNavigationController(for: myWorkout)
        self.myWorkoutNavigationController = myWorkoutNavigationController
        
        let exercises = ViewBuilder.buildExercisesScreen()
        let exercisesNavigationController = buildNavigationController(for: exercises)
        self.exercisesNavigationController = exercisesNavigationController
        
        let statistics = ViewBuilder.buildStatisticsScreen()
        let statisticsNavigationController = buildNavigationController(for: statistics)
        self.statisticsNavigationController = statisticsNavigationController
        
        let settings = ViewBuilder.buildSettingsScreen()
        let settingsNavigationController = buildNavigationController(for: settings)
        self.settingsNavigationController = settingsNavigationController
        
        self.tabBarController = tabBarController
        
        self.tabBarController?.viewControllers = [myWorkoutNavigationController, exercisesNavigationController, statisticsNavigationController, settingsNavigationController]
        self.tabBarController?.selectedIndex = TabBarDestination.myWorkout.rawValue
    }
    
    func build(screen: Screen, state: NavigationState? = nil) -> UIViewController {
        switch screen {
        case .exercisesForCategory:
            return ExercisesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        case .info:
            return InfoViewController()
        case .editExercise:
            return EditExerciseViewController()
//        case .history:
//            print("TODO")
        case .workoutSetting:
            return WorkoutSettingViewController()
        case .workoutSorting:
            return WorkoutSortingTableViewController()
        case .myWorkout:
            return MyWorkoutCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        default:
            assertionFailure("Attempt to build invalid screen \(screen)")
            return UIViewController()
        }
    }
    
    private func buildNavigationController(for vc: UIViewController) -> UINavigationController {
        let navigationController = DefaultNavigationController(rootViewController: vc)
        navigationController.navigationItem.backBarButtonItem?.title = "Backö"
        navigationController.navigationBar.backItem?.title = "Backö"
        return navigationController
    }
    
    func provideInitialView() -> UIViewController {
        return tabBarController ?? UIViewController()
    }
    
    /**
     Instantiates a new view controller
     
     - parameter identifier: The storyboard view identifier to instantiate
     - parameter storyboard: The storyboard name containing the desired view-controller
     - returns: The instantiated view-controller
     */
    static func instantiateScreen(with title: String) -> UIViewController {
        switch title {
        case NRConstants.TabBarItemTitles.myWorkout:
            return MyWorkoutCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        case NRConstants.TabBarItemTitles.exercises:
            return ExercisesCategoryCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        case NRConstants.TabBarItemTitles.statistics:
            return MainStatisticsViewController()
        case NRConstants.TabBarItemTitles.settings:
            return SettingsTableViewController()
        default:
            return UIViewController()
        }
    }
}
