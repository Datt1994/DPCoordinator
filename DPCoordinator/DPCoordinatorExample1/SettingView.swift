//
//  SettingView.swift
//  DPCoordinator
//
//  Created by Datt Patel on 29/07/25.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.settingCoordinator) private var coordinator
    @Environment(\.tabCoordinator) private var tabCoordinator
    
    var body: some View {
        VStack(spacing: 24) {
            Button("Go to Home Tab") {
                tabCoordinator?.selectTab(.home)
            }
            Button("Go to Account Tab") {
                tabCoordinator?.selectTab(.account)
            }
        }
    }
}
