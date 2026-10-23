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
            id: "hand-tracker",
            title: "Hand Tracker",
            summary: "21 landmarks drawn over the hand",
            description: "Runs a hand-pose model on each camera frame and draws the 21 landmarks with the bones between them. A small panel shows which fingers are extended.",
            inspiration: "Wanted a feel for how far a pose model gets before you need any OpenCV at all.",
            learned: "Smoothing landmarks across frames matters more than model accuracy for a stable overlay.",
            date: .sample("2026-10-09"),
            techniques: ["Pose estimation", "Landmark detection", "Convex hull"],
            tools: ["Vision", "Core ML"],
            difficulty: .worldClass,
            sourceURL: URL(string: "https://github.com/cross19xx/hand-tracker"),
            demo: .sample
        ),
        Project(
            id: "qr-scanner",
            title: "QR Scanner",
            summary: "Decode and outline QR codes live",
            description: "Finds QR codes in the live feed, outlines each one with its four corners and shows the decoded payload. Tapping a URL payload opens it.",
            inspiration: nil,
            learned: "Outlining with the detected corners instead of a bounding box makes rotation obvious to the user.",
            date: .sample("2026-09-27"),
            techniques: ["Barcode detection", "Perspective transform"],
            tools: ["Vision"],
            difficulty: .semiPro,
            sourceURL: URL(string: "https://github.com/cross19xx/qr-scanner"),
            demo: .sample
        ),
        Project(
            id: "panorama-stitcher",
            title: "Panorama Stitcher",
            summary: "Match keypoints, warp, blend two photos",
            description: "Takes two overlapping photos, finds **ORB** keypoints in each, matches them, estimates a homography with RANSAC and warps one image onto the other.",
            inspiration: "The first project where the maths from the course and the OpenCV calls lined up one to one.",
            learned: "Bad matches ruin the homography. Lowe's ratio test removed most of them before RANSAC ever ran.",
            date: .sample("2026-09-12"),
            techniques: ["Feature matching", "Homography", "RANSAC", "Image warping"],
            tools: ["OpenCV"],
            difficulty: .legendary,
            sourceURL: URL(string: "https://github.com/cross19xx/panorama-stitcher"),
            demo: nil
        ),
        Project(
            id: "lane-detection",
            title: "Lane Detection",
            summary: "Road lanes from dashcam footage",
            description: "Masks the road region, runs Canny, then a probabilistic Hough transform to pull out the two lane lines and averages them into a single left and right line per frame.",
            inspiration: "Every intro course does this one. I wanted to see how brittle it really is on real footage.",
            learned: "It is very brittle. Shadows and worn paint break the fixed thresholds within seconds.",
            date: .sample("2026-08-23"),
            techniques: ["Canny edges", "Hough transform", "Region masking"],
            tools: ["OpenCV"],
            difficulty: .professional,
            sourceURL: URL(string: "https://github.com/cross19xx/lane-detection"),
            demo: .sample
        ),
        Project(
            id: "color-tracker",
            title: "Color Tracker",
            summary: "Track one hue through the frame",
            description: "Converts each frame to HSV, thresholds a hue range chosen with a slider, and draws the centroid of the largest blob. Good for following a tennis ball.",
            inspiration: nil,
            learned: "HSV makes colour thresholds survive lighting changes that destroy them in RGB.",
            date: .sample("2026-08-04"),
            techniques: ["Colour segmentation", "Thresholding", "Image moments"],
            tools: ["OpenCV"],
            difficulty: .amateur,
            sourceURL: URL(string: "https://github.com/cross19xx/color-tracker"),
            demo: .sample
        ),
        Project(
            id: "face-detection",
            title: "Face Detection",
            summary: "Bounding boxes from a Haar cascade",
            description: "Classic Viola-Jones face detection with OpenCV's bundled Haar cascade, drawn over the camera feed. A toggle swaps in Apple's Vision detector for comparison.",
            inspiration: "I kept reading that Haar cascades are obsolete and wanted to see the gap myself.",
            learned: "The cascade is fast but misses turned faces. Vision is slower per frame and far more forgiving.",
            date: .sample("2026-07-19"),
            techniques: ["Haar cascade", "Face detection", "Sliding window"],
            tools: ["OpenCV", "Vision"],
            difficulty: .semiPro,
            sourceURL: URL(string: "https://github.com/cross19xx/face-detection"),
            demo: .sample
        ),
        Project(
            id: "document-scanner",
            title: "Document Scanner",
            summary: "Find the page, flatten it, threshold it",
            description: "Finds the largest four-sided contour in a photo, warps it to a flat rectangle and applies an adaptive threshold so the page reads like a scan.",
            inspiration: nil,
            learned: "Ordering the four corners consistently before warping was most of the work.",
            date: .sample("2026-07-03"),
            techniques: ["Contour detection", "Perspective transform", "Adaptive thresholding"],
            tools: ["OpenCV"],
            difficulty: .professional,
            sourceURL: URL(string: "https://github.com/cross19xx/document-scanner"),
            demo: nil
        ),
        Project(
            id: "edge-detector",
            title: "Edge Detector",
            summary: "Live Canny edges on the camera feed",
            description: "Runs Canny edge detection on the live camera feed. Two sliders expose the low and high hysteresis thresholds so you can watch weak edges appear and disappear in real time.",
            inspiration: "Wanted to actually understand how gradient magnitude and the two thresholds interact before trusting the defaults every tutorial copies.",
            learned: "A 5×5 Gaussian blur before Canny removes most of the noise edges. Keeping the ratio of thresholds near 1:3 gives the cleanest result.",
            date: .sample("2026-06-14"),
            techniques: ["Canny edges", "Gaussian blur", "Sobel gradients"],
            tools: ["OpenCV"],
            difficulty: .amateur,
            sourceURL: URL(string: "https://github.com/cross19xx/edge-detector"),
            demo: .sample
        )
    ]
}
#endif
