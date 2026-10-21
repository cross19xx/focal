//
//  ListLayout.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import SwiftUI

struct ListLayout: View {
    var body: some View {
        VStack(alignment: .center) {
            Text(verbatim: "The vertical items. One after the other")
                .foregroundStyle(.secondary)
                .font(.caption)
                .padding(.top, 32)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

#if DEBUG
#Preview("Light", traits: .sizeThatFitsLayout) {
    ListLayout()
}

#Preview("Dark", traits: .sizeThatFitsLayout) {
    ListLayout()
        .preferredColorScheme(.dark)
}
#endif
