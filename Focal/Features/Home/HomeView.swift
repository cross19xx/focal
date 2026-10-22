//
//  HomeView.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.projectStore) private var store

    @AppStorage("layoutStyle") private var layoutStyle: LayoutStyle = .grid

    @State private var isAboutPresented = false
    @State private var path = [DemoKind]()
    @State private var pendingDemo: DemoKind?
    @State private var selectedProject: Project?

    private var projects: [Project] { store.projects }

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("\(projects.count) project · Tap to run, long press for details")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)

                    Picker("Layout Style", selection: $layoutStyle) {
                        ForEach(LayoutStyle.allCases) { style in
                            Text(style.label).tag(style)
                        }
                    }
                    .pickerStyle(.segmented)

                    switch layoutStyle {
                    case .grid: GridLayout(
                            projects: projects,
                            onTap: viewProjectDemo,
                            onLongPress: viewProjectDetails
                        )
                    case .list: ListLayout(
                            projects: projects,
                            onTap: viewProjectDemo,
                            onLongPress: viewProjectDetails
                        )
                    case .timeline: TimelineLayout(
                            projects: projects,
                            onTap: viewProjectDemo,
                            onLongPress: viewProjectDetails
                        )
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle(String(localized: "Focal"))
            .navigationDestination(for: DemoKind.self, destination: { demoKind in
                Text(verbatim: "New Page received \(demoKind)")
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { isAboutPresented.toggle() } label: {
                        Label("About", systemImage: "info.circle")
                    }
                }
            }
            .sheet(isPresented: $isAboutPresented) {
                Text(verbatim: "About some details to be presented")
            }
            .sheet(item: $selectedProject, onDismiss: handleDetailsDismiss) { project in
                ProjectDetailSheet(project: project) {
                    pendingDemo = project.demo
                }
            }
        }
    }

    private func handleDetailsDismiss() {
        guard let demo = pendingDemo else { return }
        pendingDemo = nil
        path.append(demo)
    }

    private func viewProjectDemo(_ project: Project) {
        if let demo = project.demo {
            path.append(demo)
        } else {
            viewProjectDetails(project)
        }
    }

    private func viewProjectDetails(_ project: Project) {
        selectedProject = project
    }
}

#if DEBUG
    #Preview("Light") {
        HomeView()
            .environment(\.projectStore, ProjectStore(projects: Project.samples))
    }

    #Preview("Dark") {
        HomeView()
            .preferredColorScheme(.dark)
            .environment(\.projectStore, ProjectStore(projects: Project.samples))
    }
#endif
