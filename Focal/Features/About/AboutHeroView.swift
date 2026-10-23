//
//  AboutHeroView.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 22/10/2026.
//

import SwiftUI

struct AboutHeroView: View {
    private var appVersion: String {
        let infoDictionary = Bundle.main.infoDictionary
        let short = infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
        let bundle = infoDictionary?["CFBundleVersion"] as? String ?? "0"

        return String(localized: "Version \(short) (\(bundle))")
    }

    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "camera.aperture")
                .resizable()
                .scaledToFit()
                .frame(width: 52, height: 52)
                .padding(16)
                .background(.background.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.background.tertiary, lineWidth: 1)
                )
                .padding(.bottom, 12)

            Text("Focal")
                .font(.title2.bold())

            Text(appVersion)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#if DEBUG
#Preview("Light") {
    AboutHeroView()
}

#Preview("Dark") {
    AboutHeroView()
        .preferredColorScheme(.dark)
}
#endif
