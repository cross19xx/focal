//
//  TimelineLayout.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import SwiftUI

struct TimelineLayout: View {
    let projects: [Project]

    let onTap: (_ project: Project) -> Void
    let onLongPress: (_ project: Project) -> Void

    private let markerSize: CGFloat = 16

    private var monthGroups: [MonthGroup] {
        let groupedProjects = Dictionary(grouping: projects) { project in
            Project.calendar.dateInterval(of: .month, for: project.date)?.start ?? project.date
        }

        return groupedProjects.sorted(by: { $0.key > $1.key }).map {
            MonthGroup(month: $0.key, projects: $0.value)
        }
    }

    var body: some View {
        // `monthGroups` is a computed property;
        // By redeclaring it here, we only read it once per render
        let groups = monthGroups

        VStack(alignment: .leading, spacing: 20) {
            ForEach(groups) { group in
                let isCurrent = group.id == groups.first?.id

                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .center, spacing: 12) {
                        Circle()
                            .fill(isCurrent ? AnyShapeStyle(Color.accentColor) : AnyShapeStyle(.background))
                            .strokeBorder(.tertiary, lineWidth: isCurrent ? 0 : 2)
                            .frame(width: markerSize, height: markerSize)

                        Text(group.month.formatted(Project.dateStyle.month(.abbreviated).year()).uppercased())
                            .font(.caption.weight(.medium).monospaced())
                            .tracking(0.5)
                            .foregroundStyle(
                                isCurrent ? AnyShapeStyle(Color.accentColor) : AnyShapeStyle(.secondary)
                            )
                    }
                    .frame(height: 24)

                    ForEach(group.projects) { project in
                        TimelineCard(
                            project: project,
                            onTap: { onTap(project) },
                            onLongPress: { onLongPress(project) }
                        )
                        .padding(.leading, 28)
                    }
                }
            }
        }
        .background(alignment: .leading) {
            Rectangle()
                .fill(.background.secondary)
                .frame(width: 2)
                .padding(.leading, 7)
                .padding(.top, 8)
        }
    }
}

private struct MonthGroup: Identifiable {
    let month: Date
    let projects: [Project]

    var id: Date { month }
}

#if DEBUG
#Preview("Light", traits: .sizeThatFitsLayout) {
    let projects = Project.samples

    VStack {
        TimelineLayout(
            projects: projects,
            onTap: { print($0.title) },
            onLongPress: { print($0.title) }
        )
    }.padding()
}

#Preview("Dark", traits: .sizeThatFitsLayout) {
    let projects = Project.samples

    VStack {
        TimelineLayout(
            projects: projects,
            onTap: { print($0.title) },
            onLongPress: { print($0.title) }
        )
        .preferredColorScheme(.dark)
    }.padding()
}
#endif
