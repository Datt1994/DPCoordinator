//
//  CoordiantorNavigationStackModifier.swift
//  DPCoordinator
//
//  Created by Datt Patel on 27/07/25.
//

import SwiftUI

private struct IsInNavigationStackKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var isInNavigationStack: Bool {
        get { self[IsInNavigationStackKey.self] }
        set { self[IsInNavigationStackKey.self] = newValue }
    }
}

struct CoordiantorNavigationStackModifier<C: DPCoordinator>: ViewModifier {
    @ObservedObject var coordinator: C
    var environmentKeyPath: WritableKeyPath<EnvironmentValues, C?>
    weak var parentCoordinator: (any DPCoordinator)?
    @Environment(\.isInNavigationStack) private var isInNavigationStack
    
    func body(content: Content) -> some View {
//        if isInNavigationStack {
////            content
////                .onAppear {
////                    assertionFailure("You can not use nested NavigationStack. Use Sheet or FullScreenCover instead to created new NavigationStack or Flow. use: 'coordinator?.present(full:' or 'coordinator?.present(sheet:'")
////                }
//            
//            content
//                .task {
////                    coordinator.parentCoordinator = parentCoordinator
//                    if coordinator.navigationPath.count == 0 {
//                        assertionFailure("You can not use nested NavigationStack. Use Sheet or FullScreenCover instead to created new NavigationStack or Flow. use: 'coordinator?.present(full:' or 'coordinator?.present(sheet:'")
//                    }
////                    coordinator.parentCoordinator.present(full: content)
//                }
//                .environment(environmentKeyPath, coordinator)
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
            .environment(\.isInNavigationStack, true)
            .environment(environmentKeyPath, coordinator)
//        }
      
    }
    
}


public struct AlertConfigButton {
    let label: String
    var action: (() -> Void)?
}

public struct AlertConfig {
    var title: String?
    var message: String?
    var primaryButton: AlertConfigButton?
    var secondaryButton: AlertConfigButton?
    var isActive = false

    mutating func show(_ alert: AlertConfig) {
        self = alert
        self.isActive = true
    }

    mutating func dismiss() {
        self.isActive = false
    }
}

