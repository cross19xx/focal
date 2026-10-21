//
//  BundleTests.swift
//  FocalTests
//
//  Created by Kenneth Kwakye-Gyamfi on 21/10/2026.
//

import Foundation
import Testing

@testable import Focal

struct BundleTests {

    @Test func `App bundle carries a version and build number`() {
        let info = Bundle.main.infoDictionary ?? [:]

        #expect(info["CFBundleShortVersionString"] as? String == "0.0.1")
        #expect(info["CFBundleVersion"] as? String == "1")
    }
}
