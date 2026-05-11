//
//  MainCoordinator.swift
//  DPCoordinator
//
//  Created by Datt Patel on 29/07/25.
//

import SwiftUI

private struct MainCoordinatorKey: EnvironmentKey {
    static let defaultValue: MainCoordinator? = nil
}

extension EnvironmentValues {
    var mainCoordinator: MainCoordinator? {
        get { self[MainCoordinatorKey.self] }
        set { self[MainCoordinatorKey.self] = newValue }
    }
}

// MARK: - MainCoordinator
class MainCoordinator: AppBaseCoordinator<AppScreen> {
    @Published var tabSelection: AppTab = .home
    
    func logout() {
//        QFAuthHandler.shared.clearData()
//        loginCoordinator.start()
    }
    
    func selectTab(_ tab: AppTab) {
        tabSelection = tab
    }

}


