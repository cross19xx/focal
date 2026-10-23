//
//  Project.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import Foundation

struct Project: Codable, Hashable, Identifiable, Sendable {
    let id: String
    let title: String
    let summary: String
    let description: String
    let inspiration: String?
    let learned: String?
    let date: Date
    let techniques: [String]
    let tools: [String]
    let difficulty: ProjectDifficulty
    let sourceURL: URL?
    let demo: DemoKind?
}

extension Project {
    var hasDemo: Bool { demo != nil }

    var thumbnail: String { "thumb-\(id)" }

    var detailDate: String { date.formatted(Self.dateStyle.month(.abbreviated).day().year()) }
    var monthDate: String { date.formatted(Self.dateStyle.month(.abbreviated).year()) }
    var dayDate: String { date.formatted(Self.dateStyle.month(.abbreviated).day()) }

    /// Dates decode as UTC calendar days, so they are grouped and formatted in UTC as well;
    /// in the device's zone a date would read as the previous day anywhere west of Greenwich.
    static let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        return calendar
    }()

    static let dateStyle = Date.FormatStyle(
        locale: Locale(identifier: "en_US_POSIX"),
        calendar: calendar,
        timeZone: calendar.timeZone
    )
}
