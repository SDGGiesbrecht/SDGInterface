
/// A response to a request for a view controller during state restoration.
public struct ViewControllerRestorationResponse {

    // MARK: - Initialization

    /// Creates a response.
    public init() {}

    // MARK: - Properties

    #if canImport(UIKit)
    /// The controller.
    public var viewController: UIViewController?
    #endif
}
