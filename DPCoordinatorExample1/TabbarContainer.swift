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
    @StateObject private var coordinator = MainCoordinator()
    var body: some View {
        TabView(selection: $coordinator.tabSelection) {
            // Tab 1: Home
            MainScreenBuilder.build(.home)
                .tabItem {
                    AppTab.home.tabItem
                }
                .tag(AppTab.home)
            
            // Tab 2: Account
            MainScreenBuilder.build(.account)
                .tabItem {
                    AppTab.account.tabItem
                }
                .tag(AppTab.account)
            
            // Tab 3: Settings
            MainScreenBuilder.build(.setting)
                .tabItem {
                    AppTab.setting.tabItem
                }
                .tag(AppTab.setting)
        }
        .navigationTitle(coordinator.tabSelection.title)
        .addAppCoordiantorNavigationStack(using: coordinator, environmentKeyPath: \.mainCoordinator)
    }
}

#Preview {
    TabbarContainer()
}
