//
//  ProjectRow.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import SwiftUI

struct ProjectRow: View {
    let project: Project

    let onTap: () -> Void
    let onLongPress: () -> Void

    private var caption: String {
        let slicedTechniques = project.techniques.prefix(2)
        return slicedTechniques.joined(separator: " · ")
    }

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(project.thumbnail)
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .background(.background.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 4) {
                Text(project.title)
                    .font(.subheadline.weight(.semibold))

                Text(project.summary)
                    .lineLimit(1)
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                Text(caption)
                    .lineLimit(1)
                    .font(.caption2.monospaced())
                    .foregroundStyle(Color.accentColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.trailing, 4)

            Image(systemName: "chevron.right")
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(12)
        .pressGestures(onTap: onTap, onLongPress: onLongPress)
    }
}

#if DEBUG
#Preview("Light", traits: .fixedLayout(width: 358, height: 90)) {
    let project = Project.samples[0]

    ProjectRow(
        project: project,
        onTap: { print("Pressed") },
        onLongPress: { print("Long Pressed") }
    )
}

#Preview("Dark", traits: .fixedLayout(width: 358, height: 90)) {
    let project = Project.samples[0]

    ProjectRow(
        project: project,
        onTap: { print("Pressed") },
        onLongPress: { print("Long Pressed") }
    ).preferredColorScheme(.dark)
}
#endif
