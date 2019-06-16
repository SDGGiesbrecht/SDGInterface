
import SDGControlFlow
import SDGText
import SDGLocalization

/// An element of the user interface which can be either bound to a data model or to a static localized value.
public enum Binding<T, L> where L : Localization {

    // MARK: - Cases

    /// A static value.
    case `static`(UserFacing<T, L>)

    /// A binding to a data model.
    case binding(Shared<T>)

    // MARK: - Resolution

    public func resolved() -> T {
        switch self {
        case .static(let localized):
            return localized.resolved()
        case .binding(let shared):
            return shared.value
        }
    }
}
