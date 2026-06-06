//
//  DPCoordinator.swift
//  DPCoordinator
//
//  Created by Datt Patel on 27/07/25.
//

import SwiftUI
import Combine

// MARK: - DPCoordinator Protocol

@MainActor public protocol DPCoordinator: ObservableObject {
    associatedtype ScreenType: Screen
    associatedtype FlowType: Flow

    var navigationPath: [ScreenType.ID] { get set }
    var dicPathScreen: [ScreenType.ID: ScreenType] { get }
    var presentedSheet: ScreenType? { get set }
    var presentedFullScreenCover: ScreenType? { get set }
    var presentedFlowSheet: FlowType? { get set }
    var presentedFlowFullScreenCover: FlowType? { get set }
    var presentedAlert: AlertConfig { get set }
    var parentCoordinator: (any DPCoordinator)? { get set }
    
    // Navigation
    func push(_ screen: ScreenType)
    @discardableResult func pop(_ screenCount: Int) -> Bool
    @discardableResult func popToRoot() -> Bool
    
    // Presentation
    func present(sheet screen: ScreenType)
    func present(sheet flow: FlowType)
    @discardableResult func dismissSheetScreen() -> Bool
    func present(full screen: ScreenType)
    func present(full flow: FlowType)
    @discardableResult func dismissFullScreen() -> Bool
    @discardableResult func dismiss() -> Bool
    func showAlert(_ alert: AlertConfig)
    func dismissAlert()

}

public extension DPCoordinator {
    @discardableResult func pop() -> Bool { pop(1) }
}

// MARK: - Base Coordinator

@MainActor open class BaseCoordinator<T: Screen, F: Flow>: DPCoordinator {
    public typealias ScreenType = T
    public typealias FlowType = F

    private(set) public var dicPathScreen: [ScreenType.ID: ScreenType] = [:]
    @Published public var navigationPath: [ScreenType.ID] = []
    @Published public var presentedSheet: ScreenType?
    @Published public var presentedFullScreenCover: ScreenType?
    @Published public var presentedFlowSheet: FlowType?
    @Published public var presentedFlowFullScreenCover: FlowType?
    @Published public var presentedAlert: AlertConfig = AlertConfig()

    private var cancellables: Set<AnyCancellable> = .init()
    weak public var parentCoordinator: (any DPCoordinator)?
    
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
    public func push(_ screen: ScreenType) {
        dicPathScreen[screen.id] = screen
        navigationPath.append(screen.id)
    }
    
    // You can not use nested NavigationStack. Use Sheet or FullScreenCover instead to created new NavigationStack or Flow. use: 'coordinator?.present(full:' or 'coordinator?.present(sheet:'
    // func push(flow: FlowType) { }

    @discardableResult
    public func pop(_ screenCount: Int = 1) -> Bool {
        guard navigationPath.count >= screenCount else { return false }
        navigationPath.removeLast(screenCount)
        return true
    }

    @discardableResult
    public func popToRoot() -> Bool {
        if navigationPath.isEmpty { return false }
        navigationPath.removeAll()
        return true
    }

    // Presentation
    public func present(sheet screen: ScreenType) {
        presentedSheet = screen
    }
    
    public func present(sheet flow: FlowType) {
        presentedFlowSheet = flow
    }

    @discardableResult
    public func dismissSheetScreen() -> Bool {
        if presentedSheet == nil {
            if presentedFlowSheet == nil {
                return parentCoordinator?.dismissSheetScreen() ?? false
            }
            presentedFlowSheet = nil
            return true
        }
        presentedSheet = nil
        return true
    }

    public func present(full screen: ScreenType) {
        presentedFullScreenCover = screen
    }
    
    public func present(full flow: FlowType) {
        presentedFlowFullScreenCover = flow
    }

    @discardableResult
    public func dismissFullScreen() -> Bool {
        if presentedFullScreenCover == nil {
            if presentedFlowFullScreenCover == nil {
                return parentCoordinator?.dismissFullScreen() ?? false
            }
            presentedFlowFullScreenCover = nil
            return true
        }
        presentedFullScreenCover = nil
        return true
    }

    @discardableResult
    public func dismiss() -> Bool {
        if presentedSheet == nil && presentedFullScreenCover == nil {
            if presentedFlowSheet == nil && presentedFlowFullScreenCover == nil {
                return parentCoordinator?.dismiss() ?? false
            }
            presentedFlowSheet = nil
            presentedFlowFullScreenCover = nil
            return true
        }
        presentedSheet = nil
        presentedFullScreenCover = nil
        return true
    }
    
    public func showAlert(_ alert: AlertConfig) {
        presentedAlert.show(alert)
    }
    
    public func dismissAlert() {
        presentedAlert.dismiss()
    }
}


