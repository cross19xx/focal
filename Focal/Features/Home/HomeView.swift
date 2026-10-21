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

    private var projects: [Project] { store.projects }

    var body: some View {
        NavigationStack {
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
                    case .grid: GridLayout(projects: projects)
                    case .list: ListLayout()
                    case .timeline: TimelineLayout()
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollBounceBehavior(.basedOnSize)
            .navigationTitle(String(localized: "Focal"))
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
        }
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
