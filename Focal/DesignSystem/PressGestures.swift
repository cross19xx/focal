//
//  PressGestures.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import SwiftUI

struct PressGestures: ViewModifier {
    let onTap: () -> Void
    let onLongPress: () -> Void

    @State private var didLongPress = false

    func body(content: Content) -> some View {
        Button(action: handleTap) { content }
            .buttonStyle(PressedScale())
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.4).onEnded { _ in
                    didLongPress = true
                    onLongPress()
                }
            )
            .accessibilityAction(named: "Details") { onLongPress() }
    }

    private func handleTap() {
        if didLongPress {
            didLongPress = false
            return
        }
        onTap()
    }
}

/// Pressed look for project tiles and rows: a slight scale-down and a single haptic on touch
/// down. A `ButtonStyle` rather than gestures so the `ScrollView` keeps its touch-delay
/// handling and `VoiceOver` sees a button.
private struct PressedScale: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
            .sensoryFeedback(.impact(weight: .medium), trigger: configuration.isPressed) { _, pressed in pressed }
    }
}

extension View {
    func pressGestures(
        onTap: @escaping () -> Void,
        onLongPress: @escaping () -> Void
    ) -> some View {
        modifier(PressGestures(onTap: onTap, onLongPress: onLongPress))
    }
}
