//
//  SegmentsBetterPickerStyle.swift
//  swiftui-pick-better
//
//  Created by Ryan Jarvis on 11/5/24.
//

import Foundation
import SwiftUI

/// 'Segmented' style that mimics Apple's PickerStyle.segmented
public struct SegmentedBetterPickerStyle: BetterPickerStyle {
    /// Width of the entire Picker. Required property in order to calculate cell size correctly.
    public var frameWidth: CGFloat
    /// Height of the entire Picker. Defaults to '32', the same height used in Apple's segmented Picker.
    public var frameHeight: CGFloat
    /// Horizontal alignment for the inner ``View`` of the cells. Defaults to ``.center`` alignment.
    public var horizontalCellAlignment: HorizontalAlignment
    
    /// Memberwise initializer
    public init(
        frameWidth: CGFloat,
        frameHeight: CGFloat = 32,
        horizontalCellAlignment: HorizontalAlignment = .center
    ) {
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        self.horizontalCellAlignment = horizontalCellAlignment
    }
    
    /// Builds the overall picker ``View``.
    public func makeView(_ configuration: Configuration) -> some View {
        /// Actual width of the `View` for a cell
        let cellWidth = (frameWidth / CGFloat(configuration.cellCount)) - 1.5
        /// Index of the current cell
        let selectCellIndex = configuration.selectionIndices.first
        
        return ZStack(alignment: .leading) {
            if let selectCellIndex {
                /// Rounded background to display selected item
                RoundedRectangle(cornerRadius: 6)
                    .fill(.white)
                    .frame(
                        width: cellWidth,
                        height: (frameHeight - 4.0)
                    )
                    .offset(x: CGFloat(selectCellIndex) * cellWidth)
                    .animation(.easeInOut(duration: 0.25), value: selectCellIndex)
                    .padding(.leading, 2)
                    .shadow(color: .secondary.opacity(0.3), radius: 2, y: 1)
            }

            HStack {
                configuration.listOutput
            }
            .foregroundStyle(.black)
            .frame(width: frameWidth, height: frameHeight)
        }
        .background(Color(red: 0.92, green: 0.92, blue: 0.92))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    /// Builds each individual cell ``View``.
    public func makeListCell(_ configuration: CellConfiguration) -> some View {
        Button(action: {
            configuration.select()
        }) {
            HStack {
                if [.center, .trailing].contains(horizontalCellAlignment) {
                    Spacer()
                }
                
                configuration.label()
                    .padding(.horizontal, 6)
                
                if [.center, .leading].contains(horizontalCellAlignment) {
                    Spacer()
                }
            }
        }
        .foregroundStyle(.primary)
        .contentShape(Rectangle()) // Used to make the entire HStack tappable
    }
}

#if DEBUG
    private struct PreviewItem: Identifiable, Sendable {
        let id: UUID = UUID()
        let image: Image
        let label: String
    }

    private let items: [PreviewItem] = [
        .init(image: Image(systemName: "list.bullet"), label: "Label 1"),
        .init(image: Image(systemName: "list.bullet"), label: "Label 2"),
        .init(image: Image(systemName: "list.bullet"), label: "Label 3"),
    ]

    @MainActor
    private func itemContent(_ item: PreviewItem) -> some View {
        item.image
            .resizable()
            .frame(width: 16, height: 12)
    }
    @MainActor
    private func itemContentWithLabel(_ item: PreviewItem) -> some View {
        HStack {
            Text(item.label)
            Spacer()
            item.image
                .resizable()
                .frame(width: 16, height: 12)
        }
    }

    struct SegmentedBetterPickerStyle_Previews: PreviewProvider {
        static var previews: some View {
            VStack {
                SegmentedSelectionPreview()
                Spacer()
            }
        }
    }

    private struct SegmentedSelectionPreview: View {
        @State private var selection: PreviewItem.ID? = items.first!.id

        var body: some View {
            VStack {
                Text("BetterPicker Segmented Picker")
                BetterPicker(items, selection: $selection, content: itemContent)
                    .betterPickerStyle(
                        SegmentedBetterPickerStyle(
                            frameWidth: 160,
                            horizontalCellAlignment: .center
                        )
                    )
                    .padding(12)
                
                Text("Apple Segmented Picker")
                Picker("Choose an option", selection: $selection) {
                    ForEach(items) { item in
                        item.image
                            .tag(item.id)
                    }
                }
                .frame(width: 150)
                .pickerStyle(SegmentedPickerStyle())
                .padding(12)
                
                Text("BetterPicker Custom Style")
                BetterPicker(items, selection: $selection, content: itemContentWithLabel)
                    .betterPickerStyle(
                        SegmentedBetterPickerStyle(
                            frameWidth: 350,
                            frameHeight: 64,
                            horizontalCellAlignment: .trailing
                        )
                    )
                    .padding(12)
            }
        }
    }
#endif
