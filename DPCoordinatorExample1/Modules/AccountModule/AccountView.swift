//
//  HomeScreenView.swift
//  DPCoordinator
//
//  Created by Datt Patel on 29/07/25.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.mainCoordinator) private var coordinator
    
    var body: some View {
        VStack(spacing: 24) {
            Button("Set up account present sheet") {
                coordinator?.present(sheet: .init(flow: .accountSetUp))
            }
            Button("Set up account present full screen") {
                coordinator?.present(full: .init(flow: .accountSetUp))
            }
            Button("Go to Setting Tab") {
                coordinator?.selectTab(.setting)
            }
            Button("Go to Home Tab") {
                coordinator?.selectTab(.home)
            }
        }
    }
}
