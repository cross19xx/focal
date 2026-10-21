//
//  ProjectTile.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import SwiftUI

struct ProjectTile: View {
    let project: Project

    let onTap: () -> Void
    let onLongPress: () -> Void

    private var caption: String {
        let descriptions: [String?] = [project.techniques.first, project.monthDate]
        return descriptions.compactMap { $0 }.joined(separator: " · ")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(project.thumbnail)
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .frame(maxWidth: .infinity)
                .background(.background.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 14))

            Text(project.title)
                .font(.subheadline.weight(.semibold))

            Text(caption)
                .font(.caption2.monospaced())
                .foregroundStyle(.secondary)
        }
        .pressGestures(onTap: onTap, onLongPress: onLongPress)
    }
}

#if DEBUG
#Preview("Light", traits: .fixedLayout(width: 180, height: 200)) {
    let project = Project.samples[0]

    ProjectTile(
        project: project,
        onTap: { print("Pressed") },
        onLongPress: { print("Long Pressed") }
    )
}

#Preview("Dark", traits: .fixedLayout(width: 180, height: 200)) {
    let project = Project.samples[0]

    ProjectTile(
        project: project,
        onTap: { print("Pressed") },
        onLongPress: { print("Long Pressed") }
    ).preferredColorScheme(.dark)
}
#endif
