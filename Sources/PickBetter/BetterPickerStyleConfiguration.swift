// BetterPickerStyleConfiguration.swift
// PickBetter
//
// Copyright © 2024 MFB Technologies, Inc. All rights reserved. All rights reserved.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

import Foundation
import SwiftUI

/// Configuration payload passed to `BetterPickerStyle.makeView(_:)`
public struct BetterPickerStyleConfiguration {
    /// The view output of all the cells combined
    public let listOutput: AnyView

    /// The number of cells
    public let cellCount: Int

    /// The number of selections
    public let selectionCount: Int

    /// The indicies of all selected items
    public let selectionIndexSet: IndexSet

    /// The label views for the selected cells
    public let selectionLabels: [AnyView]
}
