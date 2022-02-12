/*
 CheckBox.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(SwiftUI) && !(os(tvOS) || os(iOS) || os(watchOS))) || canImport(AppKit)
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  import SDGInterfaceLocalizations

  /// A check box.
  public struct CheckBox<L>: LegacyView where L: Localization {

    // MARK: - Initialization

    /// Creates a button.
    ///
    /// - Parameters:
    ///     - label: The label on the button.
    ///     - isChecked: The state of the check box.
    public init(label: UserFacing<StrictString, L>, isChecked: Shared<Bool>) {
      self.label = label
      self.isChecked = isChecked
    }

    // MARK: - Properties

    private let label: UserFacing<StrictString, L>
    private let isChecked: Shared<Bool>

    // MARK: - LegacyView

    #if canImport(AppKit)
      public func cocoa() -> CocoaView {
        return useSwiftUIOrFallback(to: {
          return CocoaView(CocoaImplementation(label: label, isChecked: isChecked))
        })
      }
    #endif
  }

  @available(macOS 10.15, *)
  extension CheckBox: View {

    // MARK: - View

    #if canImport(SwiftUI)
      public func swiftUI() -> some SwiftUI.View {
        return SwiftUIImplementation(
          label: label,
          isChecked: isChecked,
          localization: LocalizationSetting.current
        )
      }
    #endif
  }
#endif

#if canImport(SwiftUI) && !(os(tvOS) || os(iOS) || os(watchOS))
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct CheckBoxPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      Group {

        previewBothModes(
          CheckBox(
            label: UserFacing<StrictString, InterfaceLocalization>({ localization in
              switch localization {
              case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Check Box"
              case .deutschDeutschland:
                return "Kontrollkästchen"
              }
            }),
            isChecked: Shared(false)
          ).adjustForLegacyMode()
            .padding(),
          name: "Check Box"
        )
      }
    }
  }
#endif
