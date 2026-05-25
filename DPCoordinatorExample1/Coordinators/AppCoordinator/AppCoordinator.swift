//
//  AppCoordinator.swift
//  DPCoordinator
//
//  Created by Datt Patel on 17/08/25.
//
import SwiftUI


// MARK: - AppCoordinator Protocol

@MainActor protocol AppCoordinator: DPCoordinator {

    var presentedLoader: LoadingConfig { get set }
    var presentedPopUpAlert: PopUpAlert { get set }

    func showLoader(_ loader: LoadingConfig?)
    func hideLoader()
    
    func showPopUpAlert(_ popUpAlert: PopUpAlert)
    func dismissPopUpAlert()
    
}

extension AppCoordinator {
    func showLoader(_ loader: LoadingConfig? = nil) {
        showLoader(loader)
    }
}

// MARK: - App Base Coordinator

@MainActor class AppBaseCoordinator<T: Screen, F: Flow>: BaseCoordinator<T, F>, AppCoordinator {
    typealias ScreenType = T
    typealias FlowType = F
    
    @Published var presentedLoader: LoadingConfig = LoadingConfig()
    @Published var presentedPopUpAlert: PopUpAlert = PopUpAlert()
    
    func showLoader(_ loader: LoadingConfig?) {
        presentedLoader.show(loader ?? LoadingConfig())
    }
    
    func hideLoader() {
        presentedLoader.hide()
    }
    
    func showPopUpAlert(_ popUpAlert: PopUpAlert) {
        presentedPopUpAlert.show(popUpAlert)
    }
    
    func dismissPopUpAlert() {
        presentedPopUpAlert.dismiss()
    }
    
}
