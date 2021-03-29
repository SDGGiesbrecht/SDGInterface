/*
 ViewWithAlert.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit
#endif

import SDGControlFlow

extension ViewWithAlert {

  #if canImport(AppKit) || (canImport(UIKit) && !os(watch))
    internal class CocoaImplementation: CocoaView.NativeType, SharedValueObserver {

      // MARK: - Initialization

      internal init(view: V, alert: Alert<L, M, N>, isPresented: Shared<Bool>) {
        self.alert = alert
        self.isPresented = isPresented
        super.init(frame: .zero)

        CocoaView(self)
          .fill(with: view.cocoa())

        isPresented.register(observer: self)
      }

      required init?(coder: NSCoder) {
        codingNotSupported()
      }

      // MARK: - Properties

      internal let alert: Alert<L, M, N>
      internal var isPresented: Shared<Bool>

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        if isPresented.value {
          alert.cocoa().runModal()
          alert.dismissalButton?.action?()
        }
      }
    }
  #endif
}
