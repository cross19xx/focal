//
//  TimelineLayout.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import SwiftUI

struct TimelineLayout: View {
    var body: some View {
        VStack(alignment: .center) {
            Text(verbatim: "Timeline view. Ordered by the date")
                .foregroundStyle(.secondary)
                .font(.caption)
                .padding(.top, 32)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

#if DEBUG
#Preview("Light", traits: .sizeThatFitsLayout) {
    TimelineLayout()
}

#Preview("Dark", traits: .sizeThatFitsLayout) {
    TimelineLayout()
        .preferredColorScheme(.dark)
}
#endif
