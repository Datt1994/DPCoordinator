//
//  AppeCoordiantorNavigationStackModifier.swift
//  DPCoordinator
//
//  Created by Datt Patel on 26/01/26.
//
import SwiftUI

struct AppCoordiantorNavigationStackModifier<C: AppCoordinator>: ViewModifier {
    @ObservedObject var coordinator: C
    var environmentKeyPath: WritableKeyPath<EnvironmentValues, C?>
    var parentCoordinator: (any AppCoordinator)?
    @Environment(\.isInNavigationStack) private var isInNavigationStack
    
    func body(content: Content) -> some View {
//        if isInNavigationStack {
//            content
//                .onAppear {
//                    coordinator.parentCoordinator = parentCoordinator
//                }
//                .showLoadingIndicator(using: _coordinator)
//                .showPopUpAlert(using: _coordinator)
//                .showAlert(using: _coordinator)
//                .environment(environmentKeyPath, coordinator)
////                .onAppear {
////                    assertionFailure("You can not use nested NavigationStack. Use Sheet or FullScreenCover instead to created new NavigationStack. use: 'coordinator?.present(full:' or 'coordinator?.present(sheet:'")
////                }
//        } else {
            content
            .addCoordiantorNavigationStack(using: coordinator, environmentKeyPath: environmentKeyPath, parentCoordinator: parentCoordinator)
            .showLoadingIndicator(using: _coordinator)
            .showPopUpAlert(using: _coordinator)
//            .environment(environmentKeyPath, coordinator)
//        }
      
    }
    
}
