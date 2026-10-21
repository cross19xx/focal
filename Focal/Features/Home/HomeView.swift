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

    var projects: [Project] { store.projects }

    var temporaryLayoutText: String {
        // Plain literals to be used inside a view is not localized
        switch layoutStyle {
        case .grid: "This is a temporary view for the grid"
        case .list: "The vertical items. One after the other"
        case .timeline: "Timeline view. Ordered by the date"
        }
    }

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

                    VStack(alignment: .center) {
                        Text(temporaryLayoutText)
                            .foregroundStyle(.secondary)
                            .font(.caption)
                            .padding(.top, 32)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
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
