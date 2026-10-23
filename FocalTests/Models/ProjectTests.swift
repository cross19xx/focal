//
//  ProjectTests.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 23/10/2026.
//

import Foundation
import Testing

@testable import Focal

@MainActor
struct ProjectTests {

    @Test func `detail date formats as month day and year`() {
        #expect(project(on: "2026-06-14").detailDate == "Jun 14, 2026")
    }

    @Test func `month date formats as month and year`() {
        #expect(project(on: "2026-06-14").monthDate == "Jun 2026")
    }

    @Test func `day date formats as month and day`() {
        #expect(project(on: "2026-06-14").dayDate == "Jun 14")
    }

    @Test func `first of the month does not shift with the device time zone`() {
        #expect(project(on: "2026-06-01").detailDate == "Jun 1, 2026")
        #expect(project(on: "2026-06-01").monthDate == "Jun 2026")
    }

    @Test func `thumbnail name derives from the ID`() {
        #expect(project(on: "2026-06-14").thumbnail == "thumb-p")
    }

    private func project(on day: String) -> Project {
        Project(
            id: "p",
            title: "Title",
            summary: "Summary",
            description: "Description",
            inspiration: nil,
            learned: nil,
            date: ProjectStore.dateFormatter.date(from: day)!,
            techniques: ["Canny edges"],
            tools: ["OpenCV"],
            difficulty: .amateur,
            sourceURL: nil,
            demo: nil
        )
    }
}
