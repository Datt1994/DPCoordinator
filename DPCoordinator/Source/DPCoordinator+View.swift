//
//  DPCoordinator+View.swift
//  DPCoordinator
//
//  Created by Datt Patel on 27/07/25.
//

import SwiftUI

// MARK: - View Extension for Navigation and Presentation

extension View {
    
    func addCoordiantorNavigationStack<S: Screen, C: DPCoordinator>(using coordinator: C, environmentKeyPath: WritableKeyPath<EnvironmentValues, C?>, parentCoordinator: (any DPCoordinator)? = nil) -> some View where C.ScreenType == S, S: Identifiable {
        modifier(CoordiantorNavigationStackModifier(coordinator: coordinator, environmentKeyPath: environmentKeyPath, parentCoordinator: parentCoordinator))
    }
    
    @ViewBuilder
    func navigationDestination<S: Screen, C: DPCoordinator>(using coordinator: ObservedObject<C>) -> some View where C.ScreenType == S, S: Identifiable {
        navigationDestination(for: S.self.ID) { id in
            coordinator.wrappedValue.dicPathScreen[id]?.build()
        }
    }

    func presentSheet<S: Screen, C: DPCoordinator>(using coordinator: ObservedObject<C>) -> some View where C.ScreenType == S, S: Identifiable {
        sheet(item: coordinator.projectedValue.presentedSheet,
              onDismiss: coordinator.wrappedValue.presentedSheet?.onDissmiss) { (screen: S) in
            screen.build()
        }
    }

    func presentFullScreenCover<S: Screen, C: DPCoordinator>(using coordinator: ObservedObject<C>) -> some View where C.ScreenType == S, S: Identifiable {
        fullScreenCover(item: coordinator.projectedValue.presentedFullScreenCover,
                        onDismiss: coordinator.wrappedValue.presentedFullScreenCover?.onDissmiss) { (screen: S) in
            screen.build()
        }
    }

    func showAlert<C: DPCoordinator>(using coordinator: ObservedObject<C>) -> some View {
        alert(coordinator.wrappedValue.presentedAlert.title ?? "", isPresented: coordinator.projectedValue.presentedAlert.isActive) {
            if let primaryButton = coordinator.wrappedValue.presentedAlert.primaryButton {
                Button(action: primaryButton.action ?? {}, label: { Text(primaryButton.label) })
            }
            if let secondaryButton = coordinator.wrappedValue.presentedAlert.secondaryButton {
                SwiftUI.Button(action: secondaryButton.action ?? {}, label: { Text(secondaryButton.label) })
            }
        } message: {
            if let message = coordinator.wrappedValue.presentedAlert.message {
                Text(message)
            }
        }
    }
//    
//    func showLoadingIndicator<S: Screen, C: DPCoordinator>(using coordinator: ObservedObject<C>) -> some View where C.ScreenType == S, S: Identifiable {
//        modifier( (coordinator: coordinator.wrappedValue, text: "Loading..."))
//    }
//    
//    func showOldPopUpAlert<S: Screen, C: DPCoordinator>(using coordinator: ObservedObject<C>) -> some View where C.ScreenType == S, S: Identifiable {
//        modifier(PopUpAlertModifier(popUpAlert: coordinator.projectedValue.presentedOldPopUpAlert))
//    }
}
