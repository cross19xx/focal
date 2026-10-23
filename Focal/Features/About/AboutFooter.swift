//
//  AboutFooter.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 23/10/2026.
//

import SwiftUI

struct AboutFooter: View {
    private var year: String {
        Date.now.formatted(.dateTime.year())
    }

    var body: some View {
        Text(String(format: String(localized: "about.footer", table: "About"), year))
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
    }
}

#if DEBUG
#Preview("Light") {
    AboutFooter()
}

#Preview("Dark") {
    AboutFooter()
        .preferredColorScheme(.dark)
}
#endif
