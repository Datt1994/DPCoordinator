//
//  PopUpAlertViewModifier.swift
//  DPCoordinator
//
//  Created by Datt Patel on 27/01/26.
//

import SwiftUI

public struct PopUpAlertButton {
    let label: String
    var action: (() -> Void)?
}

public struct PopUpAlert {
    var title: String?
    var subtitle: String?
    var message: String?
    var contentView: AnyView?
    var primaryButton: PopUpAlertButton?
    var secondaryButton: PopUpAlertButton?
    var destructiveButton: PopUpAlertButton?
    var accessibilityIdentifier: String?
    private(set) var isActive = false

    mutating func show(_ alert: PopUpAlert) {
        self = alert
        self.isActive = true
    }

    mutating func dismiss() {
        self.isActive = false
    }
}

struct PopUpAlertModifier: ViewModifier {
    @State private var animationAmount = 0.0
    @Binding var popUpAlert: PopUpAlert

    func body(content: Content) -> some View {
        ZStack {
            ZStack {
                content
                    .disabled(popUpAlert.isActive) // Optionally disable interaction
                if popUpAlert.isActive {
                    Color.purple.opacity(animationAmount * 0.05)
                        .ignoresSafeArea()
                    VisualEffectView().blur(radius: animationAmount * 3, opaque: true)
                        .ignoresSafeArea()
                }
            }
//            .blur(radius: animationAmount * 3)
            .animation(.easeInOut(duration: 0.25), value: animationAmount)
            if popUpAlert.isActive {
                VStack(alignment: .center) {
                    VStack(spacing: 12) {
                        VStack(spacing: 12) {
                            VStack(spacing: 4) {
                                if let title = popUpAlert.title {
                                    Text(title)
                                        .foregroundColor(.black)
                                        .font(.title3)
                                        .multilineTextAlignment(.center)
                                }
                                if let subtitle = popUpAlert.subtitle {
                                    Text(subtitle)
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            if let message = popUpAlert.message {
                                HStack(spacing: 0) {
                                    Text(message)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.leading)
                                        .font(.caption)
                                    Spacer(minLength: 0)
                                }
                            }
                            if let contentView = popUpAlert.contentView {
                                contentView
                            }
                        }
                        HStack(spacing: 8) {
                            if let secondaryButton = popUpAlert.secondaryButton {
                                Button(action: {
                                    animationAmount = 0.0
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                        popUpAlert.dismiss()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                            secondaryButton.action?()
                                        }
                                    }
                                }, label: {
                                    Text(secondaryButton.label)
                                })
//                                .buttonStyle(CapsuleButton)
                            }
                            if let destructiveButton = popUpAlert.destructiveButton {
                                Button(action: {
                                    animationAmount = 0.0
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                        popUpAlert.dismiss()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                            destructiveButton.action?()
                                        }
                                    }
                                }, label: {
                                    Text(destructiveButton.label)
                                })
//                                .buttonStyle(CapsuleButton(type: .destructive))
                            }
                            if let primaryButton = popUpAlert.primaryButton {
                                Button(action: {
                                    animationAmount = 0.0
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                        popUpAlert.dismiss()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                            primaryButton.action?()
                                        }
                                    }
                                }, label: {
                                    Text(primaryButton.label)
                                })
//                                .buttonStyle(CapsuleButton(type: .primary))
                            }
                        }
                    }
                    .padding(16)
                }
                .frame(alignment: .center)
                .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white.opacity(0.65)))
                .background(RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.20), radius: 150 / UIScreen.main.scale, x: 0, y: 0))
                .padding(.horizontal, UIScreen.main.bounds.width * 0.08)
                .accessibilityIdentifier(popUpAlert.accessibilityIdentifier ?? "PopUpAlert")
                .scaleEffect(0.75 + (animationAmount * 0.25))
                .opacity(animationAmount)
                .animation(.easeInOut(duration: 0.25), value: animationAmount)
                .onAppear {
                    animationAmount = 1
                }
                .onDisappear {
                    animationAmount = 0
                }
            }
        }
    }
}

struct VisualEffectView: UIViewRepresentable {

    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        let blur = UIBlurEffect()
        let animator = UIViewPropertyAnimator()
        animator.addAnimations { uiView.effect = blur }
        animator.fractionComplete = 0
        animator.stopAnimation(false)
        animator.finishAnimation(at: .current)
    }
}
