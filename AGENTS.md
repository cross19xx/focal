# AGENTS.md

Guidance for AI coding agents working in this repository.

## Project

Focal is an iOS app that showcases the computer vision / OpenCV projects I build while learning. It is a personal portfolio first and a demo runner second: the home screen lists projects, a long press opens a detail sheet (description, date, inspiration, OpenCV techniques), and an About page says what the app is and who made it.

## Stack

- **Platform**: iOS only for now (iOS 17+; the floor is set by `@Observable` and `.sensoryFeedback`, every framework below is older). No iPad-specific layout, no macOS, no watchOS.
- **UI**: SwiftUI. No UIKit view controllers unless wrapping a camera preview or a rendering surface SwiftUI can't express.
- **Language**: Swift 6 language mode. The project defaults to main-actor isolation; keep vision processing off it explicitly.
- **Camera**: AVFoundation (`AVCaptureSession`) producing `CVPixelBuffer`s; one shared pipeline that every demo plugs into.
- Vision backends (pick per project, mix freely):
  - Apple frameworks first when they do the job: Vision, Core Image, Core ML, Metal Performance Shaders, Accelerate/vImage, ARKit, RealityKit. No extra dependency, hardware-accelerated.
  - OpenCV 4.x (`opencv2.xcframework`) for classical algorithms Apple doesn't expose or for parity with what I learned in Python. All cv:: code stays behind a thin Objective-C++ bridge; Swift never imports OpenCV directly.
  - Custom Swift/Metal when the point of the project is implementing the algorithm by hand.
- **Dependencies**: keep to a minimum. OpenCV is the only third-party dependency expected; ask before adding another (including model-runtime packages — prefer converting to Core ML).

## Project Data

Projects are baked into the app bundle — there is no add/edit UI, no network, no database.

- Source of truth: `Resources/projects.json`, decoded at launch into `[Project]`.
- Thumbnails: named images in `Resources/Assets.xcassets` (`thumb-<slug>`). The name is derived from the project's `id`, not stored in the JSON. Prefer real output frames from the project over illustrations.
- Models (`.mlmodelc`) and other large assets live in `Resources/Models/`, referenced by name from the project's demo, not from the JSON.
- Adding a project = add a JSON entry + a thumbnail + (optionally) a demo view. Nothing else should need to change.

```swift
struct Project: Identifiable, Codable, Hashable {
    let id: String            // slug, e.g. "edge-detector"
    let title: String
    let summary: String       // one line, shown in list view
    let description: String   // paragraph, shown in detail
    let inspiration: String?  // why I built it, if worth saying
    let learned: String?      // optional "What I learned"
    let date: Date            // when it was built (yyyy-MM-dd in JSON)
    let techniques: [String]  // CV concepts, e.g. "Canny edges", "Homography", "Optical flow"
    let tools: [String]       // what implemented them, e.g. "OpenCV", "Vision", "Core ML", "Metal"
    let sourceURL: URL?       // GitHub link
    let difficulty: ProjectDifficulty // Using the EAFC ranking system
    let demo: DemoKind?       // which live demo view to launch, if any
}

extension Project {
    var thumbnail: String { "thumb-\(id)" }
}
```

`description`, `inspiration` and `learned` are inline Markdown: bold, italic, links and code, with blank lines between paragraphs. No headings, lists or images. Views render them through `AttributedString(markdown:options:)` with `.inlineOnlyPreservingWhitespace`, and the decode test checks each one parses.

`techniques` is the concept (library-agnostic, what a CV course would call it); `tools` is the implementation. The detail sheet shows techniques as the accent chips and tools as a quieter secondary line. Keep technique names consistent across projects so the same concept reads the same everywhere.

Dates display as `MMM d, yyyy` in detail and `MMM yyyy` in `grid/timeline`.

## Screens and behaviour

### Home (`HomeView`)

- Title "Focal", subtitle "N projects · Tap to run, long press for details".
- Two gestures on every tile, in every layout:
  - **Tap → runs the demo.** Pushes `DemoRouter.view(for: project.demo!)` on the `NavigationStack`; the demo is the product, so it gets the primary gesture. If `demo == nil` (write-up only), tap opens the detail sheet instead, and the tile shows no "live" affordance.
  - **Long press → detail sheet.** The write-up: description, date, inspiration, techniques.
- Info (ⓘ) button top-right opens `AboutView` as a sheet.
- A segmented `Picker` switches `LayoutStyle` between **Grid** (2 columns), **List** (rows with thumbnail, summary, technique line) and **Timeline** (grouped by month, newest first, vertical rule with month markers). Persist the chosen style in `@AppStorage("layoutStyle")`.
- All three layouts render the same `[Project]`; they are views, not separate data paths.
- Order: newest first in every layout.

### Long press → Detail (`ProjectDetailSheet`)

- Trigger with `.onLongPressGesture` (≈0.4s) plus haptic (`.sensoryFeedback(.impact(weight: .medium), trigger:)`); the pressed tile scales up slightly before the sheet presents (the mockup's accent ring was dropped; it didn't track the scale).
- Present as a `.sheet` with `.presentationDetents([.medium, .large])` and a visible drag indicator.
- Content, in order: title + date, technique chips, tools line, Description, Inspiration (accent rule on the left, if present), What I learned (if present), then two buttons: **View source** (opens `sourceURL`) and **Run demo** (dismisses the sheet and pushes the demo; hidden when `demo == nil` or when the sheet was opened from the demo itself).
- The sheet is reading material; it never replaces the demo as the tap destination.

### Demos (one view per project — there is no shared `DemoView`)

- Every project with a demo owns a complete SwiftUI screen in `Features/Demos/<Slug>Demo/`. A live-camera filter, a two-image before/after, a tap-to-place-points homography tool and a still-image classifier are different screens, so each project decides its own layout, controls and inputs.
- Routing: `DemoKind` is an enum with one case per project; `DemoRouter.view(for:)` switches on it and returns that project's root view. Home pushes `DemoRouter.view(for: project.demo!)` on tap. Adding a demo = add a case, add a folder, add one line to the router.
- The only things every demo screen must do: navigation title = project title; a trailing ⓘ toolbar button that opens the same `ProjectDetailSheet`; sensible defaults and a label on every control, so it is usable with no explanation.
- Shared building blocks live in `Vision/` and `DesignSystem/` and are **opt-in**: `CameraSession` + `CameraPreview`, the `FrameProcessor` protocol, `PhotoPicker`, `BeforeAfterSlider`, `ControlsPanel`. A demo uses what fits and ignores the rest; don't force a demo into a template to reuse a component.
- Camera or photo-library permission is requested by the demo that needs it on first launch, not at app start. Denied permission shows an inline explanation and a Settings link, not an alert.
- Demo screens aren't in the mockup; design each one when its project is ported, matching the app's visual language.

### About (`AboutView`)

- App icon mark, name, version from the bundle (`CFBundleShortVersionString (CFBundleVersion)`).
- "What this is" card, "Made by" card (name, one-line bio, GitHub / LinkedIn / Email rows that open externally), "Built with" chips, copyright footer.
- Static copy lives in `Resources/About.strings`, read via `String(localized:table:)` — not scattered through the view.

---

## Code organisation

```
Focal/
  App/            FocalApp.swift, AppState
  Models/         Project.swift, DemoKind.swift
  Data/           ProjectStore.swift (loads projects.json)
  Resources/      projects.json, Models/, Assets.xcassets, About.strings
  Features/
    Home/         HomeView, GridLayout, ListLayout, TimelineLayout, ProjectTile
    Detail/       ProjectDetailSheet, TechniqueChip
    About/        AboutView
    Demos/
      DemoRouter.swift          DemoKind -> that project's root view
      EdgeDetectorDemo/         EdgeDetectorDemoView + its processor, models, sub-views
      DocumentScannerDemo/      …each demo is self-contained; nothing shared lives here
  Vision/
    Camera/       CameraSession.swift, FrameProcessor protocol, preview view
    OpenCV/       OpenCVBridge.h/.mm (Obj-C++) — only if a project needs it
    Apple/        Vision-, CoreImage-, CoreML-based processors and helpers
    Metal/        shaders and MPS pipelines
    Shared/       pixel-buffer <-> CGImage conversions, timing, common types
  DesignSystem/   Typography, Spacing, reusable modifiers
FocalTests/
```

- One view per file. Previews on every view, in both color schemes (`#Preview("Dark") { … .preferredColorScheme(.dark) }`).
- State: `@Observable` models, injected via `.environment`. No singletons beyond `ProjectStore.shared` for the bundled data.
- Live-camera demos usually conform their vision step to `FrameProcessor` (`func process(_ pixelBuffer: CVPixelBuffer) -> CGImage?` or a Metal-texture variant) so they can plug into the shared `CameraSession`. The protocol is backend-agnostic: an OpenCV processor, a `VNRequest`-based processor and a Metal processor all look the same to the view. Still-image or multi-step demos don't need it.
- If two demos end up with the same sub-view, promote it to `DesignSystem/` or `Vision/Shared/` then — not before.
- Backend code never leaks its types upward: no `cv::Mat`, `VNObservation`, `MLMultiArray` or `MTLTexture` in `Features/`. Processors return images or small plain-Swift result structs (points, rects, labels).
- The Obj-C++ bridge (when present) exposes Swift-friendly APIs: `CVPixelBuffer`/`UIImage` in, `CVPixelBuffer`/`UIImage` out, parameters as `Double`.

## Conventions

- SwiftLint with the repo's `.swiftlint.yml`; otherwise follow the Swift API Design Guidelines.
- Colours are colour sets in `Resources/Assets.xcassets`, used through the generated `Color.<name>` symbols. `DesignSystem/` holds typography, spacing and modifiers, not colour values.
- Strings a user sees go through `String(localized:)` even though English is the only language — it keeps copy in one place.
- Commit messages: imperative, one line, optional body. One feature per PR.
- Test names are sentences in backtick raw identifiers, capitalised: `@Test func \`Bundled projects decode\`()`. Helpers inside a suite stay camelCase.
- Tests: `ProjectStore` decoding (every bundled project decodes, `thumb-<id>` exists in the asset catalog, `techniques` is non-empty, and the Markdown fields parse), date formatting, layout-style persistence. Processor tests on fixture images are welcome where output is deterministic.
- Signing: `DEVELOPMENT_TEAM` comes from the gitignored `Config/Local.xcconfig` via `Config/Shared.xcconfig`. Never set a team in the project file or the Signing & Capabilities dropdown; it would override the config and leak into the repo.
- Run `xcodebuild -scheme Focal -destination 'platform=iOS Simulator,name=iPhone 17' build test` before declaring work done. Camera-dependent demos are exercised on device; don't block on simulator camera support.

## Don't

- Don't add a backend, sync, analytics, or accounts. This is a bundled, offline portfolio.
- Don't add a "+"/create flow — projects are added by editing `projects.json`.
- Don't put vision-backend code (OpenCV, Vision, Core ML, Metal) anywhere outside `Vision/` and the project's own `Demos/` folder.
- Don't hard-code colours in views (no `Color(hex:)`, `Color(red:green:blue:)` or literals); add a colour set to the catalog instead. SwiftLint flags this.
- Don't reach for OpenCV by default when an Apple framework does the same thing on-device; don't reach for Apple frameworks when the project's point is implementing the algorithm itself. Say which and why in the project's `tools`.
- Don't swap the gestures: tap is the demo, long press is the write-up. Don't turn the detail sheet into a push, and don't put the demo inside a sheet.
- Don't build a generic demo shell or a declarative controls schema. Each demo is a hand-written screen; shared components are helpers it may use, not a frame it must fit.
- Don't rename the app without asking. "Focal" is the display name users see; `Focal` is the project, target and scheme.
