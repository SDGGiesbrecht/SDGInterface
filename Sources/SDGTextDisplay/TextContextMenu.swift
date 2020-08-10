/*
 TextContextMenu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  import SDGLogic
  import SDGText
  import SDGLocalization

  import SDGInterfaceBasics
  import SDGMenus
  import SDGContextMenu

  import SDGInterfaceLocalizations

  /// The context menu used by text views.
  public final class TextContextMenu {

    // MARK: - Class Properties

    /// The context menu.
    public static let contextMenu: TextContextMenu = TextContextMenu()

    // MARK: - Initialization

    private init() {
      let systemMenu =
        NSTextView.defaultMenu
        ?? NSMenu()  // @exempt(from: tests) Never nil.
      let adjustments: [MenuComponent] = [
        .entry(SDGContextMenu.ContextMenu._normalizeText()),
        .entry(SDGContextMenu.ContextMenu._showCharacterInformation()),
      ]
      var appendix: [MenuComponent] = []
      for adjustment in adjustments {
        var handled = false
        defer {
          if ¬handled {
            appendix.append(adjustment)
          }
        }
        switch adjustment {
        case .entry(let entry):
          if entry.cocoa.action == #selector(TextEditingResponder.normalizeText(_:)),
            let transformations = systemMenu.items.lazy.compactMap({ $0.submenu })
              .first(where: {
                $0.items.contains(
                  where: { $0.action == #selector(NSText.uppercaseWord(_:)) })
              })
          {
            transformations.items = transformations.items.filter({ entry in
              let action = entry.action
              if action == #selector(NSText.uppercaseWord(_:))
                ∨ action == #selector(NSText.lowercaseWord(_:))
                ∨ action == #selector(NSText.capitalizeWord(_:))
              {
                return false
              }
              return true
            })
            transformations.items.append(adjustment.cocoa())
            handled = true
          } else if entry.cocoa.action
            == #selector(TextDisplayResponder.showCharacterInformation(_:)),
            let transformations = systemMenu.items.indices.lazy
              .first(where: { index in
                let submenu = systemMenu.items[index].submenu
                return submenu?.items.contains(
                  where: { $0.action == #selector(TextEditingResponder.normalizeText(_:)) }
                ) ?? false
              })
          {
            systemMenu.items.insert(adjustment.cocoa(), at: transformations + 1)
            handled = true
          }
        default:
          unreachable()
        }
      }
      let menu = Menu(
        label: UserFacing<StrictString, InterfaceLocalization>(
          { localization in  // @exempt(from: tests) Unreachable on iOS.
            switch localization {  // @exempt(from: tests)
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Context Menu"
            case .deutschDeutschland:  // @exempt(from: tests)
              return "Kontextmenü"
            }
          }),
        entries: []
      )
      let items =
        systemMenu.items
        + appendix.map({ $0.cocoa() })  // @exempt(from: tests) No appendix yet.
      for item in items {
        if let index = item.menu?.index(of: item) {
          item.menu?.removeItem(at: index)
        }
      }
      let cocoa = menu.cocoa()
      cocoa.items = items
      self.menu = cocoa
    }

    // MARK: - Properties

    /// The menu.
    public var menu: NSMenu
  }
#endif
