//
//  AccountScreenBuilder.swift
//  DPCoordinator
//
//  Created by Datt Patel on 02/08/25.
//

import SwiftUI

extension AppScreens {
    enum AccountScreens {
        case stepOne
        case stepTwo
        case stepThree
    }
}


struct AccountScreenBuilder {

    @ViewBuilder
    static func build(_ accountScreen: AppScreens.AccountScreens) -> some View {
        switch accountScreen {
        case .stepOne:
            SetUpAccountStepOneView()
        case .stepTwo:
            SetUpAccountStepTwoView()
        case .stepThree:
            SetUpAccountStepThreeView()
        }
    }

}
