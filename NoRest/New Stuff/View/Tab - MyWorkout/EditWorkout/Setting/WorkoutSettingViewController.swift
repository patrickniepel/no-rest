//
//  WorkoutSettingViewController.swift
//  NoRest
//
//  Created by Patrick Niepel on 21.02.19.
//  Copyright © 2019 Patrick Niepel. All rights reserved.
//

import UIKit

class WorkoutSettingViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = NRConstants.TableViews.rowHeight
        tableView.sectionHeaderHeight = NRConstants.TableViews.sectionHeight
        tableView.allowsMultipleSelection = false
        tableView.allowsSelection = true
        tableView.setupDefaultBackgroundColor()
        return tableView
    }()
    
    private let nameLabel: NRLabel = {
        let label = NRLabel(with: NRConstants.Editing.nameLabel)
        label.textColor = .textColorMediumLight
        label.sizeToFit()
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        textField.adjustsFontSizeToFitWidth = true
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .default
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: NRConstants.Text.font, size: .fontSizeRegular)
        textField.keyboardAppearance = .default
        textField.keyboardType = .default
        return textField
    }()
    
    private var dataSource: WorkoutSettingTableViewDataSource?
    private var delegate: WorkoutSettingTableViewDelegate?
    private var workoutSettingCtrl = WorkoutSettingController()
    var workout: MyWorkout?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.subscribe(self) {
            $0.select {
                $0.workoutSettingState
            }
        }

        dataSource = WorkoutSettingTableViewDataSource(workoutSettingCtrl: workoutSettingCtrl)
        delegate = WorkoutSettingTableViewDelegate()
        
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.register(NRDefaultTableViewCell.self, forCellReuseIdentifier: NRConstants.CellIdentifiers.nrDefaultTableViewCell)
        view.backgroundColor = .lightBackgroundColor
        setupNavigationBar()
        hideKeyboardWhenTapped()
        setupLayout()
        fillLayout()
    }
    
    private func setupNavigationBar() {
        let sortingButton = UIBarButtonItem(title: NRConstants.BarButtonItemTitles.sortingButton, style: .plain, target: self, action: #selector(openSortingScreen))
        navigationItem.rightBarButtonItem = sortingButton
    }
    
    private func fillLayout() {
        guard let workout = workout else { return }
        nameTextField.text = workout.name
        workoutSettingCtrl.selectedExercises = workout.exercises
        tableView.reloadData()
    }
    
    func setupWorkout(_ workout: MyWorkout?) {
        if let workout = workout {
            self.workout = workout
        } else {
            self.workout = MyWorkout(name: "", exercises: [])
        }
        navigationItem.title = workout?.name ?? NRConstants.ScreenTitles.newWorkout
    }
    
    @objc private func openSortingScreen() {
        guard let workout = workout else { return }
        workout.exercises = workoutSettingCtrl.selectedExercises
        workout.name = SyntaxController.checkNameInputCorrect(text: nameTextField.text)
        
        let sortingAction = WorkoutSortingAction(workout: workout)
        store.dispatch(sortingAction)
        
        let routeAction = RouteAction(screen: .workoutSorting, in: .myWorkout)
        store.dispatch(routeAction)
    }
    
    deinit {
        store.unsubscribe(self)
    }
}

// Layout
extension WorkoutSettingViewController {
    
    private func setupLayout() {
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(tableView)
        
        setupNameLayout()
        setupTableViewLayout()
    }
    
    private func setupNameLayout() {
        let topAnchor: NSLayoutYAxisAnchor?
        if #available(iOS 11.0, *) {
            topAnchor = view.safeAreaLayoutGuide.topAnchor
        } else {
            topAnchor = view.topAnchor
        }
        
        nameLabel.anchor(top: topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: .defaultPadding, left: .defaultPadding, bottom: 0, right: 0))
        nameTextField.anchor(top: nameLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 8, left: .defaultPadding, bottom: 0, right: .defaultPadding))
    }
    
    private func setupTableViewLayout() {
        let bottomAnchor: NSLayoutYAxisAnchor?
        if #available(iOS 11.0, *) {
            bottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
        } else {
            bottomAnchor = view.bottomAnchor
        }
        tableView.anchor(top: nameTextField.bottomAnchor, leading: view.leadingAnchor, bottom: bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: .defaultPadding, left: 0, bottom: 0, right: 0))
    }
}
