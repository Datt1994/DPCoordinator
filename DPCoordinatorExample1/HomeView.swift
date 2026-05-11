//
//  HomeView.swift
//  DPCoordinator
//
//  Created by Datt Patel on 29/07/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.mainCoordinator) private var coordinator
    
    var body: some View {
        VStack(spacing: 24) {
            Button("Go to Setting Tab") {
                coordinator?.selectTab(.setting)
            }
            Button("Go to Account Tab") {
                coordinator?.selectTab(.account)
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
        }
    }
}
