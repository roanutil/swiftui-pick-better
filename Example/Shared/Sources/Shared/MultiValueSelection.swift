// MultiValueSelection.swift
// PickBetter
//
// Copyright © 2023 MFB Technologies, Inc. All rights reserved. All rights reserved.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

import Foundation
import PickBetter
import SwiftUI

@MainActor
public struct MultiValueSelection: View {
    private let items: [Item]
    private let isGridStyle: Bool
    @State private var selection: Set<Int> = []

    public init(items: [Item], isGridStyle: Bool) {
        self.items = items
        self.isGridStyle = isGridStyle
    }

    @StyleBuilder
    private var style: some BetterPickerStyle {
        if isGridStyle {
            GridBetterPickerStyle(color: .blue)
        } else {
            PlainInlineBetterPickerStyle()
        }
    }

    // MARK: Accessiblity Ids

    private var multiValuePicker: String { "multiValuePicker" }

    public var body: some View {
        LazyView(
            BetterPicker(items, selection: $selection, content: { ItemLabel(itemId: $0.id) })
                .betterPickerStyle(style)
                .accessibilityIdentifier(multiValuePicker)
        )
    }
}
