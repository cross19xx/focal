//
//  ProjectDetailSheet.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 22/10/2026.
//

import SwiftUI

struct ProjectDetailSheet: View {
    let project: Project

    let onRunDemo: (() -> Void)?

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(project.title).font(.title2.bold())

                        Text(verbatim: "\(project.detailDate) · \(project.difficulty.label)")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                            .font(.footnote.weight(.semibold))
                            .padding(8)
                    }
                    .accessibilityLabel("Close")
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.circle)
                }

                FlowLayout(spacing: 8) {
                    ForEach(project.techniques, id: \.self) { technique in
                        TechniqueChip(technique: technique)
                    }
                }

                Text(project.tools.joined(separator: " · "))
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                DetailSection(
                    title: String(localized: "Description"),
                    description: project.description
                )

                if let inspiration = project.inspiration {
                    DetailSection(
                        title: String(localized: "Inspiration"),
                        description: inspiration,
                        withLeadingBar: true
                    )
                }

                if let learned = project.learned {
                    DetailSection(
                        title: String(localized: "What I learned"),
                        description: learned
                    )
                }

                HStack(spacing: 12) {
                    if let sourceURL = project.sourceURL {
                        Link(destination: sourceURL) {
                            Text("View source")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    }

                    if project.hasDemo, let onRunDemo {
                        Button {
                            onRunDemo()
                            dismiss()
                        } label: {
                            Text("Run demo")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 28)
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

#if DEBUG
#Preview("Light") {
    ProjectDetailSheet(project: Project.samples[0], onRunDemo: { print("Run demo") })
}

#Preview("Dark") {
    ProjectDetailSheet(project: Project.samples[0], onRunDemo: { print("Run demo") })
        .preferredColorScheme(.dark)
}

#Preview("Write-up only") {
    // document-scanner: no inspiration and no demo
    ProjectDetailSheet(project: Project.samples[6], onRunDemo: { print("Run demo") })
}
#endif
