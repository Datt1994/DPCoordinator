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
        if isInNavigationStack {
            content
                .onAppear {
                    assertionFailure("You can not use nested NavigationStack. Use Sheet or FullScreenCover instead to created new NavigationStack. use: 'coordinator?.present(full:' or 'coordinator?.present(sheet:'")
                }
        } else {
            NavigationStack(path: $coordinator.navigationPath) {
                content
                    .onAppear {
                        coordinator.parentCoordinator = parentCoordinator
                    }
                    .navigationDestination(using: _coordinator)
            }
            .environment(\.isInNavigationStack, true)
            .presentSheet(using: _coordinator)
            .presentFullScreenCover(using: _coordinator)
            .environment(environmentKeyPath, coordinator)
        }
      
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

