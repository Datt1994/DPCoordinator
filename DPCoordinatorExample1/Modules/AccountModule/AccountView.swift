//
//  HomeScreenView.swift
//  DPCoordinator
//
//  Created by Datt Patel on 29/07/25.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.accountCoordinator) private var coordinator
    @Environment(\.tabCoordinator) private var tabCoordinator
    
    var body: some View {
        VStack(spacing: 24) {
            Button("Set up account push") {
                coordinator?.push( .init(account: .stepOne))
            }
            Button("Set up account present sheet") {
                coordinator?.present(sheet: .init(flow: .accountSetUp))
            }
            Button("Set up account present full screen") {
                coordinator?.present(full: .init(flow: .accountSetUp))
            }
            Button("Go to Setting Tab") {
                tabCoordinator?.selectTab(.setting)
            }
            Button("Go to Home Tab") {
                tabCoordinator?.selectTab(.home)
            }
        }
    }
}
