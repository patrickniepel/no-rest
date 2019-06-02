//
//  HistoryTableViewDelegate.swift
//  NoRest
//
//  Created by Patrick Niepel on 28.02.19.
//  Copyright © 2019 Patrick Niepel. All rights reserved.
//

import UIKit

extension HistoryTableViewController {
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .uiControl
            headerView.textLabel?.font = UIFont(name: NRConstants.Font.fontBold, size: .fontSizeLarge)
            headerView.backgroundView?.backgroundColor = .backgroundColorMain
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NRConstants.TableViews.rowHeight * 2 + 24
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NRConstants.TableViews.sectionHeight
    }
}
