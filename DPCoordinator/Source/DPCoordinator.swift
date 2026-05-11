//
//  DPCoordinator.swift
//  DPCoordinator
//
//  Created by Datt Patel on 27/07/25.
//

import SwiftUI
import Combine

// MARK: - DPCoordinator Protocol

@MainActor protocol DPCoordinator: ObservableObject {
    associatedtype ScreenType: Screen

    var navigationPath: [ScreenType.ID] { get set }
    var dicPathScreen: [ScreenType.ID: ScreenType] { get }
    var presentedSheet: ScreenType? { get set }
    var presentedFullScreenCover: ScreenType? { get set }
    var presentedAlert: AlertConfig { get set }
    var parentCoordinator: (any DPCoordinator)? { get set }
    
    // Navigation
    func push(_ screen: ScreenType)
    @discardableResult func pop(_ screenCount: Int) -> Bool
    @discardableResult func popToRoot() -> Bool
    
    // Presentation
    func present(sheet screen: ScreenType)
    @discardableResult func dismissSheetScreen() -> Bool
    func present(full screen: ScreenType)
    @discardableResult func dismissFullScreen() -> Bool
    @discardableResult func dismiss() -> Bool
    func showAlert(_ alert: AlertConfig)
    func dismissAlert()

}

extension DPCoordinator {
    @discardableResult func pop() -> Bool { pop(1) }
}

// MARK: - Base Coordinator

@MainActor class BaseCoordinator<T: Screen>: DPCoordinator {
    typealias ScreenType = T

    private(set) var dicPathScreen: [ScreenType.ID: ScreenType] = [:]
    @Published var navigationPath: [ScreenType.ID] = []
    @Published var presentedSheet: ScreenType?
    @Published var presentedFullScreenCover: ScreenType?
    @Published var presentedAlert: AlertConfig = AlertConfig()

    private var cancellables: Set<AnyCancellable> = .init()
    weak var parentCoordinator: (any DPCoordinator)?
    
    init() {
        $navigationPath
            .sink { [weak self] navigationPaths in
                self?.dicPathScreen.forEach { key, _ in
                    if !navigationPaths.contains(where: { $0 == key}) {
                        self?.dicPathScreen[key]?.onDissmiss?()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            self?.dicPathScreen[key] = nil
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }

    // Navigation
    func push(_ screen: ScreenType) {
        dicPathScreen[screen.id] = screen
        navigationPath.append(screen.id)
    }

    @discardableResult
    func pop(_ screenCount: Int = 1) -> Bool {
        guard navigationPath.count >= screenCount else { return false }
        navigationPath.removeLast(screenCount)
        return true
    }

    @discardableResult
    func popToRoot() -> Bool {
        if navigationPath.isEmpty { return false }
        navigationPath.removeAll()
        return true
    }

    // Presentation
    func present(sheet screen: ScreenType) {
        presentedSheet = screen
    }

    @discardableResult
    func dismissSheetScreen() -> Bool {
        if presentedSheet == nil {
            return parentCoordinator?.dismissSheetScreen() ?? false
        }
        presentedSheet = nil
        return true
    }

    func present(full screen: ScreenType) {
        presentedFullScreenCover = screen
    }

    @discardableResult
    func dismissFullScreen() -> Bool {
        if presentedFullScreenCover == nil {
            return parentCoordinator?.dismissSheetScreen() ?? false
        }
        presentedFullScreenCover = nil
        return true
    }

    @discardableResult
    func dismiss() -> Bool {
        if presentedSheet == nil && presentedFullScreenCover == nil {
            return parentCoordinator?.dismiss() ?? false
        }
        presentedSheet = nil
        presentedFullScreenCover = nil
        return true
    }
    
    func showAlert(_ alert: AlertConfig) {
        presentedAlert.show(alert)
    }
    
    func dismissAlert() {
        presentedAlert.dismiss()
    }
}


