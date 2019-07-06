#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
import SDGControlFlow

internal final class BindingObserver<RowData> : SharedValueObserver {

    // MARK: - Properties

    internal weak var table: Table<RowData>?

    // MARK: - SharedValueObserver

    internal func valueChanged(for identifier: String) {
        table?.refreshBindings()
    }
}
#endif
