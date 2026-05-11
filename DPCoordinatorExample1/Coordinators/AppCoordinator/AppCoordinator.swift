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

@MainActor class AppBaseCoordinator<T: Screen>: BaseCoordinator<T>, AppCoordinator {
    typealias ScreenType = T
    
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


//
//protocol AppCoordinator {
////    var presentedAlert: AlertConfig { get set }
//    var isLoading: Bool { get }
////    var presentedOldPopUpAlert: PopUpAlert { get set }
//    
//    // Loading
//    func showLoading()
//    func hideLoading()
//    
////    // Alert Presentation
////    func showAlert(_ alert: AlertConfig)
////    func dismissAlert()
////    
////    // PopUp Presentation
////    func showOldPopUpAlert(_ alert: PopUpAlert)
////    func dismissOldPopUpAlert()
//}

//class AppCoordinator: AppBaseCoordinator<AppScreen> {
//    @Published var presentedAlert: AlertConfig = AlertConfig()
//    @Published var presentedOldPopUpAlert: PopUpAlert = PopUpAlert()
//    @Published private(set) var isLoading: Bool = false
//    
//    
//    // Loading
//    func showLoading() {
//        isLoading = true
//    }
//    
//    func hideLoading() {
//        isLoading = false
//    }
    
//    // Alert Presentation
//    func showAlert(_ alert: AlertConfig) {
//        presentedAlert = alert
//        presentedAlert.isActive = true
//    }
//    
//    func dismissAlert() {
//        presentedAlert.isActive = false
//    }
//    
//    // PopUp Presentation
//    func showOldPopUpAlert(_ alert: PopUpAlert) {
//        presentedOldPopUpAlert.showPopUpAlert(alert)
//    }
//    
//    func dismissOldPopUpAlert() {
//        presentedOldPopUpAlert.dismissPopUpAlert()
//    }
//}
