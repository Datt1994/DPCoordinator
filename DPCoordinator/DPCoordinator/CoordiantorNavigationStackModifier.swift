//
//  CoordiantorNavigationStackModifier.swift
//  DPCoordinator
//
//  Created by Datt Patel on 27/07/25.
//

import SwiftUI

//extension EnvironmentValues {
//    @Entry var isInNavigationStack: Bool = false
//}

public struct CoordiantorNavigationStackModifier<C: DPCoordinator>: ViewModifier {
    @ObservedObject var coordinator: C
    var environmentKeyPath: WritableKeyPath<EnvironmentValues, C?>
    weak var parentCoordinator: (any DPCoordinator)?
//    @Environment(\.isInNavigationStack) private var isInNavigationStack
    
    public func body(content: Content) -> some View {
//        if isInNavigationStack {
//            content
//                .task {
//                    assertionFailure("You can not use nested NavigationStack. Use Sheet or FullScreenCover instead to created new NavigationStack or Flow. use: 'coordinator?.present(full:' or 'coordinator?.present(sheet:'")
//                }
//        } else {
            NavigationStack(path: $coordinator.navigationPath) {
                content
                    .task {
                        coordinator.parentCoordinator = parentCoordinator
                    }
                    .presentFlowSheet(using: _coordinator)
                    .presentFlowFullScreenCover(using: _coordinator)
                    .navigationDestination(using: _coordinator)
                    .presentSheet(using: _coordinator)
                    .presentFullScreenCover(using: _coordinator)
                    .showAlert(using: _coordinator)
            }
//            .environment(\.isInNavigationStack, true)
            .environment(environmentKeyPath, coordinator)
//        }
      
    }
    
}


public struct AlertConfigButton {
    public let label: String
    public var action: (() -> Void)?
}

public struct AlertConfig {
    public var title: String?
    public var message: String?
    public var primaryButton: AlertConfigButton?
    public var secondaryButton: AlertConfigButton?
    var isActive = false

    public mutating func show(_ alert: AlertConfig) {
        self = alert
        self.isActive = true
    }

    public mutating func dismiss() {
        self.isActive = false
    }
}

