//
//  CloseButton.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 23/10/2026.
//

import SwiftUI

struct CloseButton: View {
    enum Style { case inline, toolbar }

    var style: Style = .inline

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        switch style {
        case .inline:
            button
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
        case .toolbar:
            button
        }
    }

    private var button: some View {
        Button { dismiss() } label: {
            Label("Close", systemImage: "xmark")
                .labelStyle(.iconOnly)
                .font(.footnote.weight(.semibold))
                .padding(style == .inline ? 8 : 0)
        }
    }
}

#if DEBUG
#Preview("Light") {
    CloseButton()
}

#Preview("Dark") {
    CloseButton().preferredColorScheme(.dark)
}
#endif
