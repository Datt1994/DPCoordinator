//
//  AppCoordinator+View.swift
//  DPCoordinator
//
//  Created by Datt Patel on 26/01/26.
//
import SwiftUI

// MARK: - View Extension for Navigation and Presentation

extension View {
    
    func addAppCoordiantorNavigationStack<S: Screen, C: AppCoordinator>(using coordinator: C, environmentKeyPath: WritableKeyPath<EnvironmentValues, C?>, parentCoordinator: (any AppCoordinator)? = nil) -> some View where C.ScreenType == S, S: Identifiable {
        modifier(AppCoordiantorNavigationStackModifier(coordinator: coordinator, environmentKeyPath: environmentKeyPath, parentCoordinator: parentCoordinator))
    }
    
    func showLoadingIndicator<S: Screen, C: AppCoordinator>(using coordinator: ObservedObject<C>) -> some View where C.ScreenType == S, S: Identifiable {
        modifier(LoadingViewModifier(coordinator: coordinator.wrappedValue))
    }
    
    func showPopUpAlert<S: Screen, C: AppCoordinator>(using coordinator: ObservedObject<C>) -> some View where C.ScreenType == S, S: Identifiable {
        modifier(PopUpAlertModifier(popUpAlert: coordinator.projectedValue.presentedPopUpAlert))
    }
    
}


