//
//  SectionLabel.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 22/10/2026.
//

import SwiftUI

struct SectionLabel: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text.uppercased())
            .font(.footnote.weight(.semibold))
            .tracking(0.6)
            .foregroundStyle(.secondary)
    }
}

#if DEBUG
#Preview("Light") {
    SectionLabel("The quick brown fox")
}

#Preview("Dark") {
    SectionLabel("The quick brown fox")
        .preferredColorScheme(.dark)
}
#endif
