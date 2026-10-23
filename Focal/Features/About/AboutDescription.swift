//
//  AboutDescription.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 22/10/2026.
//

import SwiftUI

struct AboutDescription: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionLabel(String(localized: "What this is"))
                .padding(.leading, 4)

            Text(String(localized: "about.what", table: "About"))
                .font(.callout)
                .padding(16)
                .background(.background.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
#Preview("Light") {
    AboutDescription()
}

#Preview("Dark") {
    AboutDescription()
        .preferredColorScheme(.dark)
}
#endif
