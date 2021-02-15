/*
 Table.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow

  /// A table.
  public struct Table<RowData>: CocoaViewImplementation, View {

    // MARK: - Initialization

    /// Creates a table.
    ///
    /// - Parameters:
    ///     - data: The data the table represents.
    ///     - columns: An array of closures—each representing a column—which produce a corresponding cell view for a particular data entry.
    ///     - row: The data element represented by the row.
    ///     - sort: Optional. A sort order to impose on the table data.
    ///     - preceding: The data entry preceding the less‐than sign.
    ///     - following: The data entry following the less‐than sign.
    public init(
      data: Shared<[RowData]>,
      columns: [(_ row: RowData) -> AnyView],
      sort: ((_ preceding: RowData, _ following: RowData) -> Bool)? = nil
    ) {
      self.data = data
      self.columns = columns
      self.sort = sort
    }

    // MARK: - Properties

    private let data: Shared<[RowData]>
    private let columns: [(_ row: RowData) -> AnyView]
    private let sort: ((_ preceding: RowData, _ following: RowData) -> Bool)?

    // MARK: - LegacyView

    public func cocoa() -> CocoaView {
      return CocoaView(CocoaImplementation(data: data, columns: columns, sort: sort))
    }
  }
#endif

#if canImport(SwiftUI) && !(os(iOS) && arch(arm)) && !os(watchOS)
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct TablePreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      Group {
        Table(
          data: Shared<[(String, String)]>([
            ("3", "III"),
            ("2", "II"),
            ("1", "I"),
          ]),
          columns: [
            { SDGInterface.AnyView(Text(verbatim: $0.0)) },
            { SDGInterface.AnyView(Text(verbatim: $0.1)) },
          ],
          sort: { $0.0 < $1.0 }
        )
        .swiftUI()
        .previewDisplayName("Table")
      }
    }
  }
#endif
