/*
 DelegationInterceptor.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

/// An instance which intercepts particular selectors sent to a delegate and passes them to a listener instead.
public class DelegationInterceptor : NSObject {

    // MARK: - Initialization

    /// Creates an interceptor.
    ///
    /// - Parameters:
    ///     - delegate: Optional. The original delegate to forward ignored selectors to.
    ///     - listener: The object to send intercepted selectors to.
    ///     - selectors: The selectors to intercept.
    public init(delegate: NSObjectProtocol? = nil, listener: NSObjectProtocol? = nil, selectors: Set<Selector>) {
        self.delegate = delegate
        self.listener = listener
        self.selectors = selectors
    }

    // MARK: - Properties

    /// The selectors to intercept.
    public var selectors: Set<Selector>
    /// The delegate ignored selectors are forwarded to.
    public weak var delegate: NSObjectProtocol?
    /// The object intercepted selectors are sent to.
    public weak var listener: NSObjectProtocol?

    // MARK: - NSObject

    public override func forwardingTarget(for aSelector: Selector) -> Any? {
        if aSelector ∈ selectors,
            listener?.responds(to: aSelector) == true {
            return listener
        } else if delegate?.responds(to: aSelector) == true {
            return delegate
        } else {
            return super.forwardingTarget(for: aSelector)
        }
    }

    public override func responds(to aSelector: Selector) -> Bool {
        if aSelector ∈ selectors,
            listener?.responds(to: aSelector) == true {
            return true
        } else if delegate?.responds(to: aSelector) == true {
            return true
        } else {
            return super.responds(to: aSelector)
        }
    }
}

#if canImport(AppKit)
extension DelegationInterceptor : NSApplicationDelegate, NSWindowDelegate {}
#else
#if !os(watchOS)
extension DelegationInterceptor : UIApplicationDelegate {}
#endif
#endif
