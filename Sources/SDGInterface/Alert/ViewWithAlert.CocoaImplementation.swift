/*
 ViewWithAlert.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

import SDGControlFlow

extension ViewWithAlert {

  #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
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

      internal required init?(coder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      internal let alert: Alert<L, M, N>
      internal var isPresented: Shared<Bool>

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        if isPresented.value {
          #if canImport(AppKit)  // @exempt(from: tests) Would hang indefinitely.
            alert.cocoa().runModal()
            alert.dismissalButton?.action?()
          #else
            let alertController = alert.cocoa()
            self.controller?.present(alertController, animated: true, completion: nil)
          #endif
        }
      }
    }
  #endif
}
