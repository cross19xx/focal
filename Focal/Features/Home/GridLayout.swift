//
//  GridLayout.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import SwiftUI

struct GridLayout: View {
    let projects: [Project]

    let onTap: (_ project: Project) -> Void
    let onLongPress: (_ project: Project) -> Void

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
                ProjectTile(
                    project: project,
                    onTap: { onTap(project) },
                    onLongPress: { onLongPress(project) }
                )
            }
        }
    }
}

#if DEBUG
#Preview("Light", traits: .fixedLayout(width: 390, height: 600)) {
    let projects = Project.samples

    GridLayout(
        projects: projects,
        onTap: { print($0.title) },
        onLongPress: { print($0.title) }
    )
    .padding(16)
}

#Preview("Dark", traits: .fixedLayout(width: 390, height: 600)) {
    let projects = Project.samples

    GridLayout(
        projects: projects,
        onTap: { print($0.title) },
        onLongPress: { print($0.title) }
    )
    .preferredColorScheme(.dark)
    .padding(16)
}
#endif
