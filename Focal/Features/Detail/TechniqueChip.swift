//
//  TechniqueChip.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 22/10/2026.
//

import SwiftUI

struct TechniqueChip: View {
    let technique: String

    var body: some View {
        Text(technique)
            .font(.caption)
            .foregroundStyle(Color.accentColor)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.accentColor, lineWidth: 1)
            )
    }
}

#if DEBUG
#Preview("Light", traits: .sizeThatFitsLayout) {
    TechniqueChip(technique: "cv2.Canny")
}

#Preview("Dark", traits: .sizeThatFitsLayout) {
    TechniqueChip(technique: "cv2.Canny")
        .preferredColorScheme(.dark)
}
#endif
