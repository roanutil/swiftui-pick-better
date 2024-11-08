//
//  SegmentedUITests.swift
//  swiftui-pick-better
//
//  Created by Ryan Jarvis on 11/8/24.
//

import XCTest
#if os(iOS)
    import Example
#elseif os(macOS)
    import Example_macOS
#endif

final class SegmentedUITests: ExampleUITestCase {
    override var _sectionNavItem: (() throws -> XCUIElement)? {
        segmentedNavItem
    }

    override var _picker: (() throws -> XCUIElement)? {
        segmentedPicker
    }

    func sharedTestSteps() throws {

    }
}
