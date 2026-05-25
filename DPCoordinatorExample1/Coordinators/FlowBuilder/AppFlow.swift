//
//  AppFlow.swift
//  DPCoordinator
//
//  Created by Datt Patel on 25/05/26.
//
import SwiftUI

// MARK: - AppFlow
enum AppFlows { }

struct AppFlow: Flow {
    let id: UUID = UUID()
    var flowContainer: AppFlows.FlowContainers?
    var onDissmiss: (() -> Void)?

    init(flow: AppFlows.FlowContainers, onDissmiss: (() -> Void)? = nil) {
        self.flowContainer = flow
        self.onDissmiss = onDissmiss
    }


    @ViewBuilder
    func build() -> some View {
        if let flowContainer = flowContainer {
            FlowBuilder.build(flowContainer)
        }

    }

}
