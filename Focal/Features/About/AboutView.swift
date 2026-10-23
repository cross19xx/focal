//
//  AboutView.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 22/10/2026.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    AboutHeroView()
                        .padding(.top, 36)

                    AboutDescription()

                    AboutAuthor()

                    AboutBuiltWith()

                    AboutFooter()
                        .padding(.bottom, 48)
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle(String(localized: "About"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { CloseButton(style: .toolbar) }
            }
        }
    }
}

#if DEBUG
#Preview("Light") {
    AboutView()
}

#Preview("Dark") {
    AboutView()
        .preferredColorScheme(.dark)
}
#endif
