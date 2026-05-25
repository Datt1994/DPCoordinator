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
    
    func presentFlowSheet<F: Flow, C: DPCoordinator>(using coordinator: ObservedObject<C>) -> some View where C.FlowType == F, F: Identifiable {
        sheet(item: coordinator.projectedValue.presentedFlowSheet,
              onDismiss: coordinator.wrappedValue.presentedFlowSheet?.onDissmiss) { (flow: F) in
            flow.build()
        }
    }

    func presentFullScreenCover<S: Screen, C: DPCoordinator>(using coordinator: ObservedObject<C>) -> some View where C.ScreenType == S, S: Identifiable {
        fullScreenCover(item: coordinator.projectedValue.presentedFullScreenCover,
                        onDismiss: coordinator.wrappedValue.presentedFullScreenCover?.onDissmiss) { (screen: S) in
            screen.build()
        }
    }
    
    func presentFlowFullScreenCover<F: Flow, C: DPCoordinator>(using coordinator: ObservedObject<C>) -> some View where C.FlowType == F, F: Identifiable {
        fullScreenCover(item: coordinator.projectedValue.presentedFlowFullScreenCover,
                        onDismiss: coordinator.wrappedValue.presentedFlowFullScreenCover?.onDissmiss) { (flow: F) in
            flow.build()
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


struct SwipedView: View {
    @Binding var isPresented: Bool
    @Binding var isCoverVisible: Bool

    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            VStack {
                Text("Swiped In Screen")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Button("Dismiss") {
                    // Animate the dismissal moving to the right
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isCoverVisible = false
                    }
                    
                    // Delay hiding the cover so the animation plays
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isPresented = false
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(10)
            }
        }
    }
}
