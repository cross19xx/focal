//
//  LayoutStyle.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import Foundation

enum LayoutStyle: String, CaseIterable, Identifiable {
    case grid
    case list
    case timeline

    static let storageKey = "layoutStyle"

    var id: Self { self }
}

extension LayoutStyle {
    var label: String {
        switch self {
        case .grid: String(localized: "Grid")
        case .list: String(localized: "List")
        case .timeline: String(localized: "Timeline")
        }
    }
}
