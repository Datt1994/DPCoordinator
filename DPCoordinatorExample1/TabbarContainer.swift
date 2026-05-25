//
//  TabbarContainer.swift
//  DPCoordinator
//
//  Created by Datt Patel on 29/07/25.
//

import SwiftUI

enum AppTab: String {
    case home
    case account
    case setting
    
    var title: String {
        self.rawValue.capitalized
    }
    
    var image: String {
        switch self {
        case .home:
            "house.fill"
        case .account:
            "person.text.rectangle"
        case .setting:
            "gear"
        }
    }
    
    var tabItem: some View {
        Label(title, systemImage: image)
    }
}

struct TabbarContainer: View {
    @StateObject private var tabCoordinator = TabCoordinator()
    @StateObject private var homeCoordinator = HomeCoordinator()
    @StateObject private var acccountCoordinator = AccountCoordinator()
    @StateObject private var settingCoordinator = SettingCoordinator()
    var body: some View {
        Group {
            
            TabView(selection: $tabCoordinator.tabSelection) {
                // Tab 1: Home
                MainScreenBuilder.build(.home)
                    .navigationTitle(tabCoordinator.tabSelection.title)
                    .addAppCoordiantorNavigationStack(using: homeCoordinator, environmentKeyPath: \.homeCoordinator)
                    .tabItem {
                        AppTab.home.tabItem
                    }
                    .tag(AppTab.home)
                
                // Tab 2: Account
                MainScreenBuilder.build(.account)
                    .navigationTitle(tabCoordinator.tabSelection.title)
                    .addAppCoordiantorNavigationStack(using: acccountCoordinator, environmentKeyPath: \.accountCoordinator)
                    .tabItem {
                        AppTab.account.tabItem
                    }
                    .tag(AppTab.account)
                
                // Tab 3: Settings
                MainScreenBuilder.build(.setting)
                    .navigationTitle(tabCoordinator.tabSelection.title)
                    .addAppCoordiantorNavigationStack(using: settingCoordinator, environmentKeyPath: \.settingCoordinator)
                    .tabItem {
                        AppTab.setting.tabItem
                    }
                    .tag(AppTab.setting)
            }
            .environment(\.tabCoordinator, tabCoordinator)
            //        .addAppCoordiantorNavigationStack(using: coordinator, environmentKeyPath: \.mainCoordinator)
        }
    }
}

#Preview {
    TabbarContainer()
}
