//
//  HomeView.swift
//  DPCoordinator
//
//  Created by Datt Patel on 29/07/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.homeCoordinator) private var coordinator
    @Environment(\.tabCoordinator) private var tabCoordinator
    
    var body: some View {
        VStack(spacing: 24) {
            Button("Go to Setting Tab") {
                tabCoordinator?.selectTab(.setting)
            }
            Button("Go to Account Tab") {
                tabCoordinator?.selectTab(.account)
            }
            Button("Show Loader") {
//                coordinator?.showLoader(LoadingConfig(text: "text",description: "description"))
                coordinator?.showLoader()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    coordinator?.hideLoader()
                }
            }
            Button("Show popup alert") {
                coordinator?.showPopUpAlert(
                    .init(
                        title: "title",
                        subtitle: "subtitle",
                        message: "message",
                        primaryButton: .init(label: "primary", action: {
                            
                        }),
                        secondaryButton: .init(label: "secondary", action: {
                            
                        })
                    ))
            }
            
            Button("Show system alert") {
                coordinator?.showAlert(
                    .init(
                        title: "title",
                        message: "message",
                        primaryButton: .init(label: "primary", action: {
                            
                        }),
                        secondaryButton: .init(label: "secondary", action: {
                            
                        })
                    ))
            }
        }
    }
}
