//
//  SetsTableViewDelegate.swift
//  NoRest
//
//  Created by Patrick Niepel on 29.05.19.
//  Copyright © 2019 Patrick Niepel. All rights reserved.
//

import UIKit

extension CurrentWorkoutCollectionViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let cell = tableView.cellForRow(at: indexPath), cell.isSelected {
            tableView.deselectRow(at: indexPath, animated: true)
            clearTextFields()
            return nil
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedSet = exercise?.sets[safe: indexPath.row] {
            fillTextFields(with: selectedSet)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NRConstants.TableViews.rowHeight * 0.75
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NRConstants.TableViews.rowHeight * 0.75 / 2
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .white
            headerView.textLabel?.text = "asda"
            headerView.backgroundView?.backgroundColor = .red
        }
    }
}