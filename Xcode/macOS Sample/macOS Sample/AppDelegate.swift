/*
 AppDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Cocoa

import SDGInterfaceMacOSSample

class Application : NSApplication {
    private let strongDelegate = AppDelegate()
    override init() {
        super.init()
        delegate = strongDelegate
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        delegate = strongDelegate
    }
}

@NSApplicationMain
class AppDelegate : NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        print(linkedSuccessfully())
    }
}
