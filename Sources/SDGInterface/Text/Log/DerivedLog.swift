#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow

  /// A textual log derived from other data.
  public struct DerivedLog<Source>: CocoaViewImplementation {

    // MARK: - Initialization

    /// Creates a log.
    ///
    /// - Parameters:
    ///   - source: The source of the data.
    ///   - derivation: A closure which derives the log from the data.
    ///   - transparentBackground: Optional. Pass `true` to make the background transparent.
    public init(
      source: Shared<Source>,
      derivation: @escaping (Source) -> RichText,
      transparentBackground: Bool = false
    ) {
      self.source = source
      self.derivation = derivation
      self.transparentBackground = transparentBackground
    }

    // MARK: - Properties

    private let source: Shared<Source>
    private let derivation: (Source) -> RichText
    private let transparentBackground: Bool

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        let cocoa = DerivedLog.CocoaImplementation(
          source: source,
          derivation: derivation,
          transparentBackground: transparentBackground,
          logMode: true
        )
        #if !os(tvOS)
          cocoa.setEditability(false)
        #endif
        return CocoaView(cocoa)
      }
    #endif
  }
#endif
