//
//  FocalApp.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import SwiftUI

@main
struct FocalApp: App {
    private let store = ProjectStore.loadBundled()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.projectStore, store)
        }
    }
}
