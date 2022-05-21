# BetterPicker

An alternative to SwiftUI's `Picker` that supports custom styles.

## Basic Usage

```swift
struct Item: Identifiable {
    let id: Int

    init(id: Int) {
        self.id = id
    }
}

struct ItemLabel: View {
    private let itemId: String

    init(item: Item) {
        self.itemId = item.id
    }

    var body: some View {
        Text("Cell - \(itemId)")
    }
}

struct ItemPicker: View {
    private let items: [Item] = 0..<100
    @State private var selection: Item.ID = 0

    var body: some View {
        BetterPicker(items, selection: $selection, content: ItemLabel.init)
    }
}
```

## Installation
Currently, only Swift Package Manager is supported. Add it as a package via the URL:
`https://github.com/MFB-Technologies-Inc/swiftui-pick-better.git`

or

`git@github.com:MFB-Technologies-Inc/swiftui-pick-better.git`

## Supported Option Types
The options displayed in a picker must conform to `Identifiable` as that is how they are correlated to the current selection.

## Supported Selection Types
Selection values must conform to `Hashable`. Where `T` is the selection value for a given selectable item, the selection may be:
- `T`
- `Optional<T>`
- `K<T> where K: RandomAccessCollection, K.Element == T`

## Styling

Unlike SwiftUI's `PickerStyle`, `BetterPicker` supports custom styles. The `BetterPickerStyle` protocol can be implemented to create reusable styles similar to SwiftUI's `ButtonStyle`.

`BetterPicker` currently includes one builtin style `PlainInlineBetterPickerStyle` which is similar to the default iOS style of items in a vertical list.

### StyleBuilder
`BetterPicker` includes a `resultBuilder` type `StyleBuilder` for conditionally applying a style in a familiar way.

## Internals

### AnyView
`BetterPicker` does make use of view type erasure with `AnyView`. This can have side-effects for various things including animations. However, no problems have been encountered so far.

### Modification without `ViewModifier`
`BetterPicker` does not apply styles through a `ViewModifier`. Instead, an instance function on the view is used. Therefore, a style can only be applied directly on the instance of a picker. This practice does not exactly align with how SwiftUI is intended to be used. There is potential for this to cause stability problems. However, no problems of this nature have been encountered so far.

## Future Improvements
- Add support for selection values that are `Equatable` without `Hashable`
- Add support for options that are not `Identifiable`
- Change to apply styles through a ViewModifier instead of instance function

## Example
The package includes an example app in the `Example` directory with iOS, macOS, tvOS, and watchOS targets. Additionally, the example includes a more sophisticated style, `GridBetterPickerStyle`.