//
//  SegmentsBetterPickerStyle.swift
//  swiftui-pick-better
//
//  Created by Ryan Jarvis on 11/5/24.
//

import Foundation
import SwiftUI

/// 'Default' style with an inline list of cells with a trailing checkmark to indicate selection
public struct SegmentedBetterPickerStyle: BetterPickerStyle {
    /// Width of the entire Picker. Defaults to using a dynamic width based on the size of the cells.
    public var frameWidth: CGFloat?
    /// Height of the entire Picker. Defaults to "32", the same height used in Apple's segmented Picker.
    public var frameHeight: CGFloat
    
    public init(
        frameWidth: CGFloat? = nil,
        frameHeight: CGFloat = 32
    ) {
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
    }
    
    public func makeView(_ configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue)
                .frame(
                    width: frameWidth ?? 150.0 / CGFloat(configuration.cellCount),
                    height: (frameHeight - 4.0)
                )
                .offset(x: 0)
            HStack {
                configuration.listOutput
            }
            .frame(width: frameWidth, height: frameHeight)
            .background(.gray.opacity(0.14))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .frame(width: frameWidth, height: frameHeight)
        .background(.gray.opacity(0.14))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    public func makeListCell(_ configuration: CellConfiguration) -> some View {
        configuration.label()
            .padding(.horizontal, 16) // Default to mimic Apple segmented Picker
            .frame(height: (frameHeight - 4.0)) // Add consistent padding between cell and parent frame
            .foregroundStyle(Color.black)
            // .background(configuration.isSelected() ? Color.white : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 7))
            .padding(.horizontal, 2)
            .shadow(color: configuration.isSelected() ? .secondary.opacity(0.4) : .clear, radius: 2, y: 1)
            .onTapGesture {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    configuration.select()
                }
            }
    }
}

#if DEBUG
    private struct PreviewItem: Identifiable, Sendable {
        let id: UUID = UUID()
        let image: Image
    }

    private let items: [PreviewItem] = [
        .init(image: Image(systemName: "list.bullet")),
        .init(image: Image(systemName: "list.bullet")),
        .init(image: Image(systemName: "list.bullet")),
    ]

    @MainActor
    private func itemContent(_ item: PreviewItem) -> some View {
        HStack {
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
                Text("Optional Selection")
                BetterPicker(items, selection: $selection, content: itemContent)
                    .betterPickerStyle(
                        SegmentedBetterPickerStyle(
                            // frameWidth: 280
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
            }
        }
    }
#endif
