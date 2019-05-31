//
//  StatisticsViewController.swift
//  NoRest
//
//  Created by Patrick Niepel on 11.02.19.
//  Copyright © 2019 Patrick Niepel. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.showsCancelButton = true
        searchBar.barTintColor = .red
        searchBar.showsSearchResultsButton = false
        searchBar.tintColor = .uiControl
        searchBar.keyboardType = .default
        searchBar.keyboardAppearance = .default
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColorUIControl
        return view
    }()
    
    let statisticsCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .backgroundColorMain
        cv.register(StatsContainerCollectionViewCell.self, forCellWithReuseIdentifier: NRConstants.CellIdentifiers.statsContainerCollectionViewCell)
        cv.isScrollEnabled = true
        cv.isPagingEnabled = true
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false

        if let layout = cv.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        return cv
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .backgroundColorUIControl
        pageControl.currentPageIndicatorTintColor = .uiControl
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    private var swipeGesture: UISwipeGestureRecognizer!
    
    let padding: CGFloat = NRConstants.Padding.collectionViewItem
    var stats: [StatsType: [StatsContainerItem]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .backgroundColorMain
        navigationItem.title = NRConstants.ScreenTitles.statistics
        
        setupCollectionView()
        setupLayout()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stats[StatsType.general] = StatisticsController.provideGeneralStats()
        stats[StatsType.exercisesForCategory] = []
        pageControl.numberOfPages = stats.count
    }
    
    private func setupCollectionView() {
        statisticsCollectionView.dataSource = self
        statisticsCollectionView.delegate = self
    }
    
    private func setupLayout() {
        view.addSubviews(searchBar, separator, statisticsCollectionView, pageControl)
        
        if #available(iOS 11.0, *) {
            pageControl.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, centerX: view.centerXAnchor)
        } else {
            pageControl.anchor(top: nil, leading: nil, bottom: view.bottomAnchor, trailing: nil, centerX: view.centerXAnchor)
        }
        
        searchBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        
        separator.anchor(top: searchBar.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: searchBar.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 32), size: CGSize(width: 0, height: 1))
        
        statisticsCollectionView.anchor(top: separator.bottomAnchor, leading: view.leadingAnchor, bottom: pageControl.topAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 24, left: 0, bottom: 8, right: 0))
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.uiControl], for: .normal)
        
        //Dye icon
        if let textField = self.searchBar.value(forKey: "searchField") as? UITextField,
            let iconView = textField.leftView as? UIImageView {
            
            textField.backgroundColor = .backgroundColorUIControl
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = .uiControl
        }
    }
    
    func updatePageControl(page: Int) {
        pageControl.currentPage = page
    }
    
    func injectExercisesStats(for category: Category) {
        stats[StatsType.exercisesForCategory] = StatisticsController.provideExercisesStats(for: category)
        
        //Reload exercises item
        statisticsCollectionView.reloadItems(at: [IndexPath(item: 1, section: 0)])
    }

}

extension StatisticsViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let currentCell = statisticsCollectionView.visibleCells.first as? StatsContainerCollectionViewCell, !searchText.isBlank else { return }
        
        currentCell.scrollToSection(searchText)
    }
}

