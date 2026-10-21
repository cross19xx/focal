//
//  ProjectStore.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import Foundation

struct ProjectStore: Sendable {
    static let resourceName = "projects"

    let projects: [Project]

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()

        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "UTC")

        return formatter
    }()

    static func load(from bundle: Bundle = .main) throws -> ProjectStore {
        guard let url = bundle.url(forResource: resourceName, withExtension: "json") else {
            throw CocoaError(.fileNoSuchFile)
        }

        return try decode(Data(contentsOf: url))
    }

    /**
     * An abstraction over the `ProjectStore.load` that ensures that a fatal error is caught and presented in a cleaner approach
     */
    static func loadBundled() -> ProjectStore {
        do {
            return try load()
        } catch {
            fatalError("projects.json failed to load: \(error)")
        }
    }

    static func decode(_ data: Data) throws -> ProjectStore {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Self.dateFormatter)

        let projects = try decoder.decode([Project].self, from: data)

        return ProjectStore(projects: projects.sorted { $0.date > $1.date })
    }

    func project(id: Project.ID) -> Project? {
        projects.first { $0.id == id }
    }
}
