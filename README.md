<div align="center">

# Focal

**A pocket portfolio of computer vision experiments, built while learning.**

<p>
  <img alt="iOS 17+" src="https://img.shields.io/badge/iOS-17%2B-000000?style=flat-square&logo=apple&logoColor=white">
  <img alt="Swift 6" src="https://img.shields.io/badge/Swift-6-F05138?style=flat-square&logo=swift&logoColor=white">
  <img alt="SwiftUI" src="https://img.shields.io/badge/UI-SwiftUI-0A84FF?style=flat-square">
  <img alt="OpenCV" src="https://img.shields.io/badge/OpenCV-4.x-5C3EE8?style=flat-square&logo=opencv&logoColor=white">
</p>

<sub>Screenshots are on their way. The first demo is still being ported.</sub>

</div>

<br />

Focal is an iOS app that runs the computer vision projects I build as I work through OpenCV and Apple's vision frameworks. Each project ships inside the app as a live demo and a short write-up: what it does, why I built it, what I learned and which techniques it leans on. The home screen is the index. Tap a project to run it on the camera or a photo; long press to read about it.

It is a portfolio first and a demo runner second. There is no backend, no accounts and no network. Everything is bundled.

<br />

## Projects

| Project                     | Techniques | Built with | Status |
| :-------------------------- | :--------- | :--------- | :----- |
| _First project coming soon_ |            |            |        |

Each row above is a demo you can open in the app. The table grows as projects are ported from Python notebooks into Swift.

<br>

## How it works

**Two gestures, every tile.** Tap runs the demo, since the demo is the product. Long press opens the write-up as a sheet. Projects without a demo yet open their write-up on tap.

**Three layouts, one list.** Grid, list and timeline views all render the same bundled projects, newest first. The chosen layout is remembered between launches.

**Apple frameworks first.** Vision, Core Image, Core ML, Metal and Accelerate do most of the work with no extra dependencies and full hardware acceleration. OpenCV steps in for classical algorithms Apple doesn't expose, or when I want parity with what I learned in Python. When the point of a project is implementing the algorithm by hand, it is written in Swift or Metal directly.

**One screen per demo.** Every demo is its own hand-written SwiftUI screen. A live camera filter, a before-and-after slider and a tap-to-place homography tool are different things, so they get different layouts. Shared pieces such as the camera session and frame processor protocol are there to be used, never required.

<br>

## Running it

Open `Focal.xcodeproj` in Xcode 26 or later and run the `Focal` scheme. Camera demos need a physical device; everything else works in the simulator.

To run on a device, give Xcode your signing team once. Copy the example config and put your team ID in it:

```sh
cp Config/Local.xcconfig.example Config/Local.xcconfig
```

The file is gitignored, so the project never carries anyone's team, and the simulator builds without it.

```sh
xcodebuild -scheme Focal -destination 'platform=iOS Simulator,name=iPhone 17' build
```

<br>

## Adding a project

A project is a JSON entry, a thumbnail and, optionally, a demo view.

1. Add an entry to `Focal/Resources/projects.json` with its title, summary, date, techniques, tools and source link.
2. Drop a thumbnail into `Resources/Assets.xcassets` named `thumb-<slug>`. Real output frames beat illustrations.
3. For a live demo, add a case to `DemoKind`, create `Features/Demos/<Slug>Demo/`, and add one line to `DemoRouter`.

Nothing else should need to change.

<br>

## Layout

```
Focal/
  App/            entry point and app state
  Models/         Project, DemoKind
  Data/           ProjectStore, loads projects.json at launch
  Resources/      projects.json, models, asset catalog, copy
  Features/       Home, Detail, About, and one folder per demo
  Vision/         camera pipeline, OpenCV bridge, Apple and Metal processors
  DesignSystem/   typography, spacing, modifiers
```

Vision code never leaks upward. Views receive images and small plain-Swift results, never a `cv::Mat`, a `VNObservation` or an `MTLTexture`.

<br>

## Made by

Kenneth Kwakye-Gyamfi. Built in public as a learning log, so expect rough edges in the early projects and fewer in the later ones.

<br>

<div align="center">
<sub>MIT licensed. See <code>LICENSE</code>.</sub>
</div>
