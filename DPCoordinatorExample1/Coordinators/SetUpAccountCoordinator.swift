//
//  SetUpAccountCoordinator.swift
//  DPCoordinator
//
//  Created by Datt Patel on 02/08/25.
//

import SwiftUI

private struct SetUpAccountCoordinatorKey: EnvironmentKey {
    static let defaultValue: SetUpAccountCoordinator? = nil
}

extension EnvironmentValues {
    var setUpAccountCoordinator: SetUpAccountCoordinator? {
        get { self[SetUpAccountCoordinatorKey.self] }
        set { self[SetUpAccountCoordinatorKey.self] = newValue }
    }
}

// MARK: - SetUpAccountCoordinator
class SetUpAccountCoordinator: AppBaseCoordinator<AppScreen> {


}

struct SetUpAccountFlowContainer: View {
    @StateObject private var coordinator = SetUpAccountCoordinator()
    @Environment(\.mainCoordinator) private var parentCoordinator
    
    var body: some View {
        SetUpAccountStepOneView()
            .addAppCoordiantorNavigationStack(using: coordinator, environmentKeyPath: \.setUpAccountCoordinator, parentCoordinator: parentCoordinator)
    }
}
