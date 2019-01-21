//
//  NavigationState.swift
//  Push
//
//  Created by Patrick Niepel on 21.01.19.
//  Copyright © 2019 Patrick Niepel. All rights reserved.
//

import ReSwift

struct NavigationState: StateType, Equatable {
    var screen: Screen?
    var action: NavigationAction
    var mainStack: [Screen]
}

