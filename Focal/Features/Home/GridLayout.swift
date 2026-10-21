//
//  GridLayout.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import SwiftUI

struct GridLayout: View {
    let projects: [Project]

    var body: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible()), // Second column doesn't need a spacer
            ],
            alignment: .leading,
            spacing: 16
        ) {
            ForEach(projects) { project in
                ProjectTile(project: project)
            }
        }
    }
}

#if DEBUG
#Preview("Light", traits: .fixedLayout(width: 390, height: 600)) {
    let projects = Project.samples

    GridLayout(projects: projects)
        .padding(16)
}

#Preview("Dark", traits: .fixedLayout(width: 390, height: 600)) {
    let projects = Project.samples

    GridLayout(projects: projects)
        .preferredColorScheme(.dark)
        .padding(16)
}
#endif
