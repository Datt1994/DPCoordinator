//
//  FlowBuilder.swift
//  DPCoordinator
//
//  Created by Datt Patel on 27/07/25.
//

import SwiftUI

enum AppFlows {
    enum FlowContainers {
        case tabbar
        case accountSetUp
    }
}


struct FlowBuilder {

    @ViewBuilder
    static func build(_ flowContainer: AppFlows.FlowContainers) -> some View {
        switch flowContainer {
            // Containers to start flow
        case .tabbar:
            TabbarContainer()
            //                QFWiFiPodsFlowContainer(viewModel: viewModel)
            
        case .accountSetUp:
            SetUpAccountFlowContainer()
        }
    }

}
