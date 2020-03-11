/*
 CharacterInformation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  import Foundation
  #if canImport(CoreGraphics)
    import CoreGraphics
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow
  import SDGLogic
  import SDGText

  import SDGInterfaceBasics
  import SDGViews
  import SDGTables
  import SDGWindows
  import SDGPopOvers

  import SDGInterfaceLocalizations

  /// User‐presentable Unicode information about the characters in a string.
  public struct CharacterInformation {

    // MARK: - Static Methods

    /// Displays information to the user about the characters in a string.
    ///
    /// - Parameters:
    ///     - characters: The string whose characters should be described.
    ///     - origin: The view and selection the characters originate from. If provided, the information will be shown in a pop‐up view instead of a separate window.
    ///     - view: The view the characters originate from.
    ///     - selection: The rectangle the characters originate from.
    @available(iOS 9, *)  // @exempt(from: unicode)
    public static func display(
      for characters: String,
      origin: (view: AnyView, selection: Rectangle?)?
    ) {
      var details: [CharacterInformation] = []
      details.reserveCapacity(characters.scalars.count)
      for scalar in characters.scalars {
        details.append(CharacterInformation(scalar))
      }

      let table = Table<CharacterInformation>(
        data: Shared(details),
        columns: [
          { details in
            // @exempt(from: tests) iOS does not call this unless it displays.
            let codePoint = Label<InterfaceLocalization>(text: .binding(Shared(details.codePoint)))
            codePoint.textColour = details.warningColour
            return AnyView(codePoint)
          },
          { details in
            // @exempt(from: tests) iOS does not call this unless it displays.
            let codePoint = Label<InterfaceLocalization>(
              text: .binding(Shared(StrictString(details.character)))
            )
            #if canImport(AppKit)
              codePoint.specificCocoaView.stringValue = details.character
            #elseif canImport(UIKit)
              codePoint.specificCocoaView.text = details.character
            #endif
            codePoint.textColour = details.warningColour
            return AnyView(codePoint)
          },
          { details in
            // @exempt(from: tests) iOS does not call this unless it displays.
            return AnyView(
              Label<InterfaceLocalization>(
                text: .binding(Shared(StrictString(details.normalizedCodePoints)))
              )
            )
          },
          { details in
            // @exempt(from: tests) iOS does not call this unless it displays.
            return AnyView(
              Label<InterfaceLocalization>(
                text: .binding(Shared(StrictString(details.normalizedCharacters)))
              )
            )
          }
        ]
      )

      if let origin = origin {
        var preferredSize: Size?
        #if canImport(AppKit)
          preferredSize = Window<InterfaceLocalization>.auxiliarySize
        #endif
        origin.view.displayPopOver(
          table,
          sourceRectangle: origin.selection,
          preferredSize: preferredSize
        )
      } else {
        #if canImport(AppKit)
          let window = Window<InterfaceLocalization>.auxiliaryWindow(
            name: .binding(Shared(StrictString(characters))),
            view: table.padding().cocoa()
          )
          window.display()
        #endif
      }
    }

    // MARK: - Initialization

    private init(_ character: Unicode.Scalar) {
      let characterString = String(character)
      codePoint = StrictString(character.hexadecimalCode)

      var normalizedCharacters = StrictString(character)
      if normalizedCharacters.scalars.elementsEqual(characterString.unicodeScalars) {
        normalizedCharacters = ""
      }

      var normalizedCodePointsString: StrictString = ""
      for scalar in normalizedCharacters.scalars {
        if ¬normalizedCodePointsString.isEmpty {
          normalizedCodePointsString += " "
        }

        normalizedCodePointsString += StrictString(scalar.hexadecimalCode)
      }
      normalizedCodePoints = normalizedCodePointsString

      if ¬normalizedCharacters.isEmpty {
        if characterString ≠ characterString.decomposedStringWithCompatibilityMapping {
          // Compatibility character.
          warningColour = .red
        } else {
          // Precomposed, but still canonical
          warningColour = .blue
        }
      } else {
        switch character {
        case "\u{22}", "\u{27}", "\u{2D}", "\\", "^", "_", "`", "~":
          warningColour = Colour(red: 0.5, green: 0.5, blue: 0)  // Code‐only ASCII
        default:
          warningColour = .black  // Normal
        }
      }

      self.character = character.visibleRepresentation
      let printable = normalizedCharacters.scalars.map { StrictString($0.visibleRepresentation) }
      self.normalizedCharacters = printable.reduce("") { $0 + $1 }
    }

    // MARK: - Properties

    private let character: String
    private let codePoint: StrictString
    private let normalizedCodePoints: StrictString
    private let normalizedCharacters: StrictString
    private let warningColour: Colour
  }
#endif
