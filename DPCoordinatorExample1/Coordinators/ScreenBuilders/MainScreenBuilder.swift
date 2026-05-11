//
//  MainScreenBuilder.swift
//  DPCoordinator
//
//  Created by Datt Patel on 27/07/25.
//

import SwiftUI

extension AppScreens {
    enum MainScreens {
        case home
        case account
        case setting
    }
}


struct MainScreenBuilder {

    @ViewBuilder
    static func build(_ mainScreen: AppScreens.MainScreens) -> some View {
        switch mainScreen {
        case .home:
            HomeView()
        case .account:
            AccountView()
        case .setting:
            SettingView()
        }
    }

}
