//
//  SetUpAccountStepThreeView.swift
//  DPCoordinator
//
//  Created by Datt Patel on 02/08/25.
//

import SwiftUI

struct SetUpAccountStepThreeView: View {
    @Environment(\.setUpAccountCoordinator) private var coordinator
    
    var body: some View {
        VStack(spacing: 24) {
            Button("Back") {
                coordinator?.pop()
            }
            Button("Root") {
                coordinator?.popToRoot()
            }
            Button("pop two") {
                coordinator?.pop(2)
            }
            Button("Dissmiss") {
                coordinator?.dismiss()
            }
        }
        .navigationTitle("Set Up Account Step 3")
    }
}
