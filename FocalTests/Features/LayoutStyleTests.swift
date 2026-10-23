//
//  LayoutStyleTests.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 23/10/2026.
//

import Foundation
import Testing

@testable import Focal

@MainActor
struct LayoutStyleTests {

    @Test func `raw values stay stable for persisted preferences`() {
        #expect(LayoutStyle.grid.rawValue == "grid")
        #expect(LayoutStyle.list.rawValue == "list")
        #expect(LayoutStyle.timeline.rawValue == "timeline")
    }

    @Test func `stored style round trips through user defaults`() throws {
        let suite = "LayoutStyleTests"
        let defaults = try #require(UserDefaults(suiteName: suite))
        defaults.removePersistentDomain(forName: suite)

        defaults.set(LayoutStyle.timeline.rawValue, forKey: LayoutStyle.storageKey)
        let stored = try #require(defaults.string(forKey: LayoutStyle.storageKey))

        #expect(LayoutStyle(rawValue: stored) == .timeline)
    }

    @Test func `unknown stored style is rejected so the default applies`() {
        #expect(LayoutStyle(rawValue: "carousel") == nil)
    }
}
