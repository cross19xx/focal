//
//  Project+Samples.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import Foundation

#if DEBUG
extension Date {
    static func sample(_ day: String) -> Date {
        ProjectStore.dateFormatter.date(from: day)!
    }
}

extension Project {
    static let samples: [Project] = [
        Project(
            id: "edge-detector",
            title: "Edge Detector",
            summary: "Live Canny edges from the camera",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum justo efficitur, mattis ante in, ullamcorper risus. Donec porta metus ac justo blandit malesuada.",
            inspiration: nil,
            learned: "Nullam in ante dignissim justo volutpat lobortis",
            date: .sample("2026-09-14"),
            techniques: ["Canny Edges", "Gaussian Blur"],
            tools: ["OpenCV"],
            difficulty: .amateur,
            sourceURL: URL(string: "https://github.com/react/react"),
            demo: .sample
        )
    ]
}
#endif
