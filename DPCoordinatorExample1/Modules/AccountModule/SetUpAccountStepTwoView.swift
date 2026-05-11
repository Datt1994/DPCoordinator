//
//  SetUpAccountStepTwoView.swift
//  DPCoordinator
//
//  Created by Datt Patel on 02/08/25.
//

import SwiftUI

struct SetUpAccountStepTwoView: View {
    @Environment(\.setUpAccountCoordinator) private var coordinator
    
    var body: some View {
        VStack(spacing: 24) {
            Button("Go to Step three") {
                coordinator?.push(.init(account: .stepThree))
            }
            Button("Back") {
                coordinator?.pop()
            }
            Button("Dissmiss") {
                coordinator?.dismiss()
            }
        }
        .navigationTitle("Set Up Account Step 2")
    }
}
