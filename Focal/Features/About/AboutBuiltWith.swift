//
//  AboutBuiltWith.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 23/10/2026.
//

import SwiftUI

struct AboutBuiltWith: View {
    private let tools = ["SwiftUI", "OpenCV 4", "AVFoundation"]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionLabel(String(localized: "Built with"))
                .padding(.leading, 4)

            FlowLayout(spacing: 8) {
                ForEach(tools, id: \.self) { tool in
                    TechniqueChip(technique: tool)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
#Preview("Light") {
    AboutBuiltWith()
}

#Preview("Dark") {
    AboutBuiltWith()
        .preferredColorScheme(.dark)
}
#endif
