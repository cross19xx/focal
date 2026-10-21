//
//  HomeView.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                String(localized: "No projects yet"),
                systemImage: "camera.metering.matrix"
            )
            .navigationTitle(String(localized: "Focal"))
        }
    }
}

#Preview("Light") {
    HomeView()
}

#Preview("Dark") {
    HomeView()
        .preferredColorScheme(.dark)
}
