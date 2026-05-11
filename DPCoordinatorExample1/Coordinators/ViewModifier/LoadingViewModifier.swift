//
//  LoadingViewModifier.swift
//  DPCoordinator
//
//  Created by Datt Patel on 27/01/26.
//
import SwiftUI

public struct LoadingConfig {
    var text: String?
    var description: String?
    var isLoading: Bool = false
    
    mutating func show(_ loader: Self) {
        self = loader
        self.isLoading = true
    }
    
    mutating func hide() {
        self.isLoading = false
    }
}

struct LoadingViewModifier<C: AppCoordinator>: ViewModifier {
    @ObservedObject var coordinator: C
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(coordinator.presentedLoader.isLoading) // Optionally disable interaction
            
            if coordinator.presentedLoader.isLoading {
                LoadingIndicatorView(text: coordinator.presentedLoader.text, descrption: coordinator.presentedLoader.description)
            }
        }
    }
}



struct LoadingIndicatorView: View {
    var text: String?
    var descrption: String?
    var body: some View {
        ZStack {
            Color.black.opacity(0.05)
                .edgesIgnoringSafeArea(.all)
            //                VisualEffectView().blur(radius: 3, opaque: true)
            VStack(alignment: .center, spacing: 8) {
                ProgressView()
                    .controlSize(.large)
                    .padding(12)
                if let text = text {
                    Text(text)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .padding(.bottom, 9)
                }
                if let descrption = descrption {
                    Text(descrption)
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 9)
                }
            }
            .padding(12)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea()
    }
}
