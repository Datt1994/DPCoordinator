//
//  SettingView.swift
//  DPCoordinator
//
//  Created by Datt Patel on 29/07/25.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.mainCoordinator) private var coordinator
    
    var body: some View {
        VStack(spacing: 24) {
            Button("Go to Home Tab") {
                coordinator?.selectTab(.home)
            }
            Button("Go to Account Tab") {
                coordinator?.selectTab(.account)
            }
        }
    }
}
