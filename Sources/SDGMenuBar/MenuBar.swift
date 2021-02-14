/*
 MenuBar.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  import SDGMathematics
  import SDGText
  import SDGLocalization

  import SDGInterface
  import SDGMenus

  import SDGInterfaceLocalizations

  /// An application’s menu bar.
  ///
  /// `MenuBar` is a fully localized version of Interface Builder’s template with several useful additions.
  ///
  /// Some menu items only appear if the application provides details they need to operate:
  /// - “Preferences...” appears if the application has a preference manager.
  /// - “Help” appears if a help book is specified in the `Info.plist` file.
  public struct MenuBar {

    // MARK: - Initialization

    /// Creates a menu bar.
    ///
    /// - Parameters:
    ///   - applicationSpecificSubmenus: Application‐specific submenus to place before the “Window” menu.
    public init(
      applicationSpecificSubmenus: [AnyMenu]
    ) {
      menu = Menu(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Menu Bar"
          case .deutschDeutschland:
            return "Menüleiste"
          }
        }),
        entries: [
          .submenu(MenuBar.application()),
          .submenu(MenuBar.file()),
          .submenu(MenuBar.edit()),
          .submenu(MenuBar.format()),
          .submenu(MenuBar.view()),
        ] + applicationSpecificSubmenus.lazy.map({ .submenu($0) }) + [
          .submenu(MenuBar.window()),
          .submenu(MenuBar.help()),
        ]
      )
    }

    // MARK: - Properties

    private let menu: AnyMenu

    /// The menu bar as an `NSMenu`.
    public func cocoa() -> NSMenu {
      return menu.cocoa()
    }

    // MARK: - Items

    internal static func fallbackApplicationName(
      quotationMarks: (leading: StrictString, trailing: StrictString)
    ) -> StrictString {
      var result = quotationMarks.leading
      result.append("\u{2068}")
      result.append(contentsOf: ApplicationNameForm.localizedIsolatedForm.resolved())
      result.append("\u{2069}")
      result.append(contentsOf: quotationMarks.trailing)
      return result
    }
  }
#endif
