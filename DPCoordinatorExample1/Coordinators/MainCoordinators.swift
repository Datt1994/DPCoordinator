//
//  MainCoordinator.swift
//  DPCoordinator
//
//  Created by Datt Patel on 29/07/25.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var tabCoordinator: TabCoordinator? = nil
    @Entry var homeCoordinator: HomeCoordinator? = nil
    @Entry var accountCoordinator: AccountCoordinator? = nil
    @Entry var settingCoordinator: SettingCoordinator? = nil
}


// MARK: - TabCoordinator

@MainActor class TabCoordinator: ObservableObject {
    @Published var tabSelection: AppTab = .home
    
    func logout() {
//        loginCoordinator.start()
    }
    
    func selectTab(_ tab: AppTab) {
        tabSelection = tab
    }

}


// MARK: - HomeCoordinator
class HomeCoordinator: AppBaseCoordinator<AppScreen, AppFlow> { }
 
// MARK: - AccountCoordinator
class AccountCoordinator: AppBaseCoordinator<AppScreen, AppFlow> { }

// MARK: - SettingCoordinator
class SettingCoordinator: AppBaseCoordinator<AppScreen, AppFlow> { }
