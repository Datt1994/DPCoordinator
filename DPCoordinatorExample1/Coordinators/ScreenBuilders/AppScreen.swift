//
//  AppScreen.swift
//  DPCoordinator
//
//  Created by Datt Patel on 27/07/25.
//

import SwiftUI

// MARK: - AppScreen
enum AppScreens { }

struct AppScreen: Screen {
    let id: UUID = UUID()
    var flowContainer: AppFlows.FlowContainers?
    var mainScreen: AppScreens.MainScreens?
    var accountScreen: AppScreens.AccountScreens?
    var onDissmiss: (() -> Void)?

    init(flow: AppFlows.FlowContainers, onDissmiss: (() -> Void)? = nil) {
        self.flowContainer = flow
        self.onDissmiss = onDissmiss
    }

    init(main: AppScreens.MainScreens, onDissmiss: (() -> Void)? = nil) {
        self.mainScreen = main
        self.onDissmiss = onDissmiss
    }
    
    init(account: AppScreens.AccountScreens, onDissmiss: (() -> Void)? = nil) {
        self.accountScreen = account
        self.onDissmiss = onDissmiss
    }


    @ViewBuilder
    func build() -> some View {
        if let flowContainer = flowContainer {
            FlowBuilder.build(flowContainer)
        }
        if let mainScreen = mainScreen {
            MainScreenBuilder.build(mainScreen)
        }
        if let accountScreen = accountScreen {
            AccountScreenBuilder.build(accountScreen)
        }
    }

}
