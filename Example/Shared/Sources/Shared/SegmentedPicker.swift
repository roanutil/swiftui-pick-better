//
//  SegmentedPicker.swift
//  Shared
//
//  Created by Ryan Jarvis on 11/8/24.
//

import Foundation
import PickBetter
import SwiftUI

public struct SegmentedPickerView: View {
    private let items: [Item]
    @State private var selection: Item.ID = 0

    public init(items: [Item]) {
        self.items = items
    }

    // MARK: Accessibility Ids

    private var segmentedPicker: String { "segmentedPicker" }
    
    public struct SegmentedItemLabel: View {
        private let itemId: Int

        public init(itemId: Int) {
            self.itemId = itemId
        }

        public var body: some View {
            HStack {
                Text(String(itemId))
                Image(systemName: "list.bullet")
            }
        }
    }

    public var body: some View {
        LazyView(
            BetterPicker(items, selection: $selection, content: { SegmentedItemLabel(itemId: $0.id) })
                .betterPickerStyle(SegmentedBetterPickerStyle(frameWidth: 500.0))
                .accessibilityIdentifier(segmentedPicker)
        )
    }
}
