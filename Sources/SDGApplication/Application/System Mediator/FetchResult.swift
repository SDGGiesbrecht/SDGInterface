/*
 FetchResult.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A fetch result.
public enum FetchResult : CaseIterable {

    // MARK: - Initialization

    #if canImport(UIKit) && !os(watchOS)
    public init(_ native: UIBackgroundFetchResult) {
        switch native {
        case .newData:
            self = .newData
        case .noData:
            self = .noData
        case .failed:
            self = .failed
        @unknown default:
            self = .failed
        }
    }
    #endif

    // MARK: - Cases

    /// New data was downloaded.
    case newData

    /// No new data to download.
    case noData

    /// A download attempt failed.
    case failed

    // MARK: - Properties

    #if canImport(UIKit) && !os(watchOS)
    public var native: UIBackgroundFetchResult {
        switch self {
        case .newData:
            return .newData
        case .noData:
            return .noData
        case .failed:
            return .failed
        }
    }
    #endif
}
