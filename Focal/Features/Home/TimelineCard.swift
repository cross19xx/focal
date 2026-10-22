//
//  TimelineCard.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 22/10/2026.
//

import SwiftUI

struct TimelineCard: View {
    let project: Project

    let onTap: () -> Void
    let onLongPress: () -> Void

    private var caption: String {
        let timelineDate = project.date.formatted(.dateTime.month(.abbreviated).day())
        let captionValues = [timelineDate, project.techniques.first].compactMap { $0 }

        return captionValues.joined(separator: " · ")
    }

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(project.thumbnail)
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .background(.background.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 2) {
                Text(project.title)
                    .font(.subheadline.weight(.semibold))

                Text(caption)
                    .lineLimit(1)
                    .font(.caption2.monospaced())
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(.background.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .pressGestures(onTap: onTap, onLongPress: onLongPress)
    }
}

#if DEBUG
#Preview("Light", traits: .fixedLayout(width: 358, height: 90)) {
    let project = Project.samples[0]

    TimelineCard(
        project: project,
        onTap: { print("Pressed") },
        onLongPress: { print("Long Pressed") }
    )
}

#Preview("Dark", traits: .fixedLayout(width: 358, height: 90)) {
    let project = Project.samples[0]

    TimelineCard(
        project: project,
        onTap: { print("Pressed") },
        onLongPress: { print("Long Pressed") }
    ).preferredColorScheme(.dark)
}
#endif
