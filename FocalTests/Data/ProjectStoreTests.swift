//
//  ProjectStoreTests.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import Foundation
import Testing
import UIKit

@testable import Focal

@MainActor
struct ProjectStoreTests {

    @Test func `bundled projects decode`() throws {
        let store = try ProjectStore.load()

        for project in store.projects {
            #expect(!project.techniques.isEmpty, "\(project.id) has no technique")
            #expect(!project.title.isEmpty, "\(project.id) has no title")
            #expect(
                UIImage(named: project.thumbnail, in: .main, with: nil) != nil,
                "\(project.id) is missing asset \(project.thumbnail)"
            )
        }
    }

    @Test func `bundled project IDs are unique`() throws {
        let ids = try ProjectStore.load().projects.map(\.id)

        #expect(Set(ids).count == ids.count)
    }

    @Test func `lookup by ID finds every bundled project`() throws {
        let store = try ProjectStore.load()

        for project in store.projects {
            #expect(store.project(id: project.id) == project)
        }
        #expect(store.project(id: "does-not-exist") == nil)
    }

    @Test func `projects are sorted by newest first`() throws {
        let store = try ProjectStore.decode(json([
            entry(id: "older", date: "2025-01-01"),
            entry(id: "newer", date: "2026-06-30"),
        ]))

        #expect(store.projects.map(\.id) == ["newer", "older"])
    }

    @Test func `date decodes as UTC calendar day`() throws {
        let store = try ProjectStore.decode(json([entry(id: "p", date: "2026-03-09")]))
        let date = try #require(store.projects.first?.date)

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let parts = calendar.dateComponents([.year, .month, .day], from: date)

        #expect(parts.year == 2026)
        #expect(parts.month == 3)
        #expect(parts.day == 9)
    }

    @Test func `missing demo decodes as nil`() throws {
        let store = try ProjectStore.decode(json([entry(id: "p", date: "2026-01-01")]))

        #expect(store.projects.first?.demo == nil)
        #expect(store.projects.first?.hasDemo == false)
    }

    @Test func `unknown demo fails decoding`() {
        let data = json([entry(id: "p", date: "2026-01-01", demo: "not-a-real-demo")])

        #expect(throws: DecodingError.self) {
            try ProjectStore.decode(data)
        }
    }

    @Test func `missing JSON file throws`() {
        #expect(throws: (any Error).self) {
            try ProjectStore.load(from: Bundle(for: TestBundleToken.self))
        }
    }

    @Test func `unknown difficulty fails decoding`() {
        let data = json([entry(id: "p", date: "2026-01-01", difficulty: "sunday-league")])

        #expect(throws: DecodingError.self) {
            try ProjectStore.decode(data)
        }
    }

    private func entry(
        id: String,
        date: String,
        demo: String? = nil,
        difficulty: String = "amateur") -> String {
        let demoField = demo.map { ", \"demo\": \"\($0)\"" } ?? ""
        return """
        {
          "id": "\(id)",
          "title": "Title",
          "summary": "Summary",
          "description": "Description",
          "inspiration": "Inspiration",
          "date": "\(date)",
          "techniques": ["Canny edges"],
          "tools": ["OpenCV"]\(demoField),
          "difficulty": "\(difficulty)"
        }
        """
    }

    private func json(_ entries: [String]) -> Data {
        Data("[\(entries.joined(separator: ","))]".utf8)
    }
}

private final class TestBundleToken {}
