//
//  Screen.swift
//  DPCoordinator
//
//  Created by Datt Patel on 27/07/25.
//
import SwiftUI

// MARK: - Screen Protocol
protocol Screen: Identifiable {
    associatedtype View: SwiftUI.View
    @ViewBuilder func build() -> View
    var id: UUID { get }
    var onDissmiss: (() -> Void)? { get set }
}
