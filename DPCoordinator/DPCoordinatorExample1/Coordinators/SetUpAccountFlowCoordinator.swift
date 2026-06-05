//
//  SetUpAccountCoordinator.swift
//  DPCoordinator
//
//  Created by Datt Patel on 02/08/25.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var setUpAccountCoordinator: SetUpAccountFlowCoordinator? = nil
}

// MARK: - SetUpAccountCoordinator
class SetUpAccountFlowCoordinator: AppBaseCoordinator<AppScreen, AppFlow> {
}

struct SetUpAccountFlowContainer: View {
    @StateObject private var coordinator = SetUpAccountFlowCoordinator()
    @Environment(\.accountCoordinator) private var parentCoordinator
    
    var body: some View {
        SetUpAccountStepOneView()
            .addAppCoordiantorNavigationStack(using: coordinator, environmentKeyPath: \.setUpAccountCoordinator, parentCoordinator: parentCoordinator)
    }
}
