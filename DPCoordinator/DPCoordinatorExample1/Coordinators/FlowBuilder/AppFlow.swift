//
//  AppFlow.swift
//  DPCoordinator
//
//  Created by Datt Patel on 25/05/26.
//
import SwiftUI

// MARK: - AppFlow
enum AppFlows {
    case tabbar
    case accountSetUp
}

struct AppFlow: Flow {
    let id: UUID = UUID()
    var flowContainer: AppFlows?
    var onDissmiss: (() -> Void)?

    init(flow: AppFlows, onDissmiss: (() -> Void)? = nil) {
        self.flowContainer = flow
        self.onDissmiss = onDissmiss
    }


    @ViewBuilder
    func build() -> some View {
        switch flowContainer {
        case .tabbar:
            TabbarContainer()
        case .accountSetUp:
            SetUpAccountFlowContainer()
        case .none:
            EmptyView()
        }
    }

}
