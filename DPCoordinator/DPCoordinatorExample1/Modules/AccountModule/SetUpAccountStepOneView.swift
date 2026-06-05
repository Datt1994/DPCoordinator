//
//  SetUpAccountStepOne.swift
//  DPCoordinator
//
//  Created by Datt Patel on 02/08/25.
//

import SwiftUI

struct SetUpAccountStepOneView: View {
    @Environment(\.setUpAccountCoordinator) private var setUpAccountCoordinator
    @Environment(\.accountCoordinator) private var accountCoordinator
    
    func coordinator() -> (AppBaseCoordinator<AppScreen, AppFlow>)? {
        return setUpAccountCoordinator ?? accountCoordinator
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Button("Go to Step two") {
                coordinator()?.push(AppScreen(account: .stepTwo))
            }
            Button("Dissmiss") {
                coordinator()?.dismiss()
            }
            Button("Back") {
                coordinator()?.pop()
            }
        }
        .navigationTitle("Set Up Account Step 1")
        .toolbar(.hidden, for: .tabBar)
    }
}
