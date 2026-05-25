//
//  Flow.swift
//  DPCoordinator
//
//  Created by Datt Patel on 25/05/26.
//
import SwiftUI

// MARK: - Flow Protocol
protocol Flow: Identifiable {
    associatedtype View: SwiftUI.View
    @ViewBuilder func build() -> View
    var id: UUID { get }
    var onDissmiss: (() -> Void)? { get set }
}
