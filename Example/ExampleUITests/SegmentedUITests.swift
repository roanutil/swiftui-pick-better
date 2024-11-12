//
//  SegmentedUITests.swift
//  Example
//
//  Created by Ryan Jarvis on 11/12/24.
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

    func testSelectSegmentedPickerItems() throws {
        _ = try sectionNavItem().waitForExistence(timeout: 1)
        XCTAssert(try sectionNavItem().exists, "Navigation link/tab for 'Segmented' picker must exist")
        try sectionNavItem().trigger()

        _ = try picker().waitForExistence(timeout: 1)
        XCTAssert(try picker().exists, "Segmented picker must exist")
        _ = try segmentedButtonZero().waitForExistence(timeout: 1)
        _ = try segmentedButtonOne().waitForExistence(timeout: 1)

        XCTAssert(try segmentedButtonZero().exists, "Cell Zero must exist")
        XCTAssert(try segmentedButtonOne().exists, "Cell One must exist")
        XCTAssert(
            try segmentedButtonZero().isSelected && (!segmentedButtonOne().isSelected),
            "Initial state should have cell Zero selected"
        )

        try segmentedButtonOne().trigger()
        XCTAssert(try segmentedButtonOne().isSelected, "'1' should be selected after being tapped")
        XCTAssert(try !segmentedButtonZero().isSelected, "'0' should not be selected before being tapped.")

        try segmentedButtonTwo().trigger()
        XCTAssert(try segmentedButtonTwo().isSelected, "'2' should still be selected without being tapped again to deselect")
        XCTAssert(try !segmentedButtonOne().isSelected, "'1' should be selected after being tapped.")

        try segmentedButtonOne().trigger()
        XCTAssert(try segmentedButtonOne().isSelected, "'1' should still be selected without being tapped again to deselect")
        XCTAssert(try !segmentedButtonTwo().isSelected, "'2' should no longer be selected after being tapped again to deselect")
    }
}
