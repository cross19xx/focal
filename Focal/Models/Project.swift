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

    var detailDate: String { date.formatted(.dateTime.month(.abbreviated).day().year()) }
    var monthDate: String { date.formatted(.dateTime.month(.abbreviated).year()) }
}
