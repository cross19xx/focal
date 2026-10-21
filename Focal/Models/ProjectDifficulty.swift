//
//  ProjectDifficulty.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import Foundation

enum ProjectDifficulty: String, Codable, Sendable {
    case amateur
    case semiPro
    case professional
    case worldClass
    case legendary
    case ultimate
}

extension ProjectDifficulty {
    var label: String {
        switch self {
        case .amateur: String(localized: "Amateur")
        case .semiPro: String(localized: "Semi-Pro")
        case .professional: String(localized: "Professional")
        case .worldClass: String(localized: "World Class")
        case .legendary: String(localized: "Legendary")
        case .ultimate: String(localized: "Ultimate")
        }
    }
}
