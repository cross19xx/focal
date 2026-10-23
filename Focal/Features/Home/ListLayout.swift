//
//  ListLayout.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import SwiftUI

struct ListLayout: View {
    let projects: [Project]

    let onTap: (_ project: Project) -> Void
    let onLongPress: (_ project: Project) -> Void

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            ForEach(projects) { project in
                let isLast = project.id == projects.last?.id

                ProjectRow(
                    project: project,
                    onTap: { onTap(project) },
                    onLongPress: { onLongPress(project) }
                )

                if !isLast { Divider() }
            }
        }
        .background(.background.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#if DEBUG
#Preview("Light", traits: .sizeThatFitsLayout) {
    let projects = Project.samples

    VStack {
        ListLayout(
            projects: projects,
            onTap: { print($0.title) },
            onLongPress: { print($0.title) }
        )
    }.padding()
}

#Preview("Dark", traits: .sizeThatFitsLayout) {
    let projects = Project.samples

    VStack {
        ListLayout(
            projects: projects,
            onTap: { print($0.title) },
            onLongPress: { print($0.title) }
        )
        .preferredColorScheme(.dark)
    }.padding()
}
#endif
