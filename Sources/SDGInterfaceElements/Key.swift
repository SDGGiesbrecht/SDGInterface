/*
 Key.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(Carbon)
import Carbon
#endif

import SDGLogic

/// Represents a physical key on the keyboard. These are useful for defining controls with a consistent arrangement.
///
/// Text keys are named by their hand position in proper typing technique:
///
/// - `left`/`right` hand
/// - `Index`/`Middle`/`Ring`/`Little` finger, `Inside` (reaching inward with an index finger), or `Outside`/`DoubleOutside` (reaching outward with a little finger)
/// - `Top`/`Upper`/`Home`/`Lower` row
///
/// `thumbs` refers to what is commonly a space bar.
///
/// The same key can represent many different characters depending on the user’s current virtual keyboard or input source.
public enum Key : CaseIterable {

    // MARK: - Cases

    /// Left of the left little finger, top row (ISO only).
    case leftOutsideTopISO
    /// Left little finger, top row.
    case leftLittleTop
    /// Left ring finger, top row.
    case leftRingTop
    /// Left middle finger, top row.
    case leftMiddleTop
    /// Left index finger, top row.
    case leftIndexTop
    /// Right of the left index finger, top row.
    case leftInsideTop
    /// Left of the right index finger, top row.
    case rightInsideTop
    /// Right index finder, top row.
    case rightIndexTop
    /// Right middle finger, top row.
    case rightMiddleTop
    /// Right ring finger, top row.
    case rightRingTop
    /// Right little finger, top row.
    case rightLittleTop
    /// Right of the right little finger, top row.
    case rightOutsideTop
    /// Two columns to the right of the right little finger, top row.
    case rightDoubleOutsideTop
    /// Three columns right of the right little finger, top row (JIS only).
    case rightTripleOutsideTopJIS
    /// Delete (backspace).
    case deleteBackspace

    /// Tabulation.
    case tabulation
    /// Left little finger, upper row.
    case leftLittleUpper
    /// Left ring finger, upper row.
    case leftRingUpper
    /// Left middle finger, upper row.
    case leftMiddleUpper
    /// Left index finger, upper row.
    case leftIndexUpper
    /// Right of the left index finger, upper row.
    case leftInsideUpper
    /// Left of the right index finger, upper row.
    case rightInsideUpper
    /// Right index finger, upper row.
    case rightIndexUpper
    /// Right middle finger, upper row.
    case rightMiddleUpper
    /// Right ring finger, upper row.
    case rightRingUpper
    /// Right little finger, upper row.
    case rightLittleUpper
    /// Right of the right little finger, upper row.
    case rightOutsideUpper
    /// Two columns to the right of the right little finger, upper row.
    case rightDoubleOutsideUpper

    /// Caps lock (left end of the home row on ISO/ANSI, bottom right on JIS).
    case capsLockLeftHomeISO_ANSI_CapsLockRightBottomJIS
    /// Left little finger, home row.
    case leftLittleHome
    /// Left ring finger, home row.
    case leftRingHome
    /// Left middle finger, home row.
    case leftMiddleHome
    /// Left index finger, home row.
    case leftIndexHome
    /// Right of the left index finger, home row.
    case leftInsideHome
    /// Left of the right index finger, home row.
    case rightInsideHome
    /// Right index finger, home row.
    case rightIndexHome
    /// Right middle finger, home row.
    case rightMiddleHome
    /// Right ring finger, home row.
    case rightRingHome
    /// Right little finger, home row.
    case rightLittleHome
    /// Right of the right little finger, home row.
    case rightOutsideHome
    /// Right of the right little finger, home row on ISO/JIS; three columns right of the right little finger, upper row on ANSI.
    case rightDoubleOutsideHomeISO_JIS_RightTripleOutsideUpperANSI
    /// Return.
    case `return`

    /// Shift (left).
    case shiftLeft
    /// Left of the left little finger, home row on ISO; left of the left little finger, top row on ANSI/JIS.
    case leftOutsideLowerISO_LeftOutsideTopANSI_JIS
    /// Left little finger, lower row.
    case leftLittleLower
    /// Left ring finger, lower row.
    case leftRingLower
    /// Left middle finger, lower row.
    case leftMiddleLower
    /// Left index finger, lower row.
    case leftIndexLower
    /// Right of the left index finger, lower row.
    case leftInsideLower
    /// Left of the right index finger, lower row.
    case rightInsideLower
    /// Right index finger, lower row.
    case rightIndexLower
    /// Right middle finger, lower row.
    case rightMiddleLower
    /// Right middle finger, lower row.
    case rightRingLower
    /// Right little finger, lower row.
    case rightLittleLower
    /// Right of the right little finger on a JIS keyboard.
    case rightOutsideLowerJIS
    /// Shift (right).
    case shiftRight

    /// Function.
    case function
    /// Control (left) (bottom row on ISO/ANSI, home row on JIS).
    case controlLeftBottomISO_ANSI_ControlLeftHomeJIS
    /// Option (left).
    case optionLeft
    /// Command (left).
    case commandLeft
    /// 英数 (ジス).
    case 英数ジス
    /// Space bar.
    case thumbs
    /// かな (ジス).
    case かなジス
    /// Command (right).
    case commandRight
    /// Option (right).
    case optionRight
    /// Control (right) (ISO/ANSI only).
    case controlRightISO_ANSI


    /// Help.
    case help
    /// Home.
    case home
    /// Page up.
    case pageUp

    /// Delete (forward).
    case deleteForward
    /// End.
    case end
    /// Page down.
    case pageDown

    /// Up arrow.
    case arrowUp
    /// Left arrow.
    case arrowLeft
    /// Down arrow.
    case arrowDown
    /// Right arrow.
    case arrowRight


    /// Clear (number pad).
    case clear
    /// Middle finger, top row on the number pad (Mac models only).
    case padMiddleTopMac
    /// Ring finger, top row on the number pad on Mac models; middle finger, top row on PC models.
    case padRingTopMac_padMiddleTopPC
    /// Little finger, top row on the number pad on Mac models; ring finger, top row on PC models.
    case padLittleTopMac_padRingTopPC

    /// Index finger, upper row on the number pad.
    case padIndexUpper
    /// Middle finger, upper row on the number pad.
    case padMiddleUpper
    /// Ring finger, upper row on the number pad.
    case padRingUpper
    /// Little finger, upper row on the number pad on Mac models; little finger top row on PC models.
    case padLittleUpperMac_padLittleTopPC

    /// Index finger, home row on the number pad.
    case padIndexHome
    /// Middle finger, home row on the number pad.
    case padMiddleHome
    /// Ring finger, home row on the number pad.
    case padRingHome
    /// Little finger, home row on the number pad.
    case padLittleHome

    /// Index finger, lower row on the number pad.
    case padIndexLower
    /// Middle finger, lower row on the number pad.
    case padMiddleLower
    /// Ring finger, lower row on the number pad.
    case padRingLower
    /// Enter (number pad).
    case enterPad

    /// Thumb on the number pad (zero).
    case padThumb
    /// Middle finger bottom row on the number pad (JIS only).
    case padMiddleBottomJIS
    /// Ring finger, bottom row on the number pad (decimal).
    case padRingBottom


    /// Escape.
    case escape
    /// F1.
    case f1
    /// F2.
    case f2
    /// F3.
    case f3
    /// F4.
    case f4
    /// F5.
    case f5
    /// F6.
    case f6
    /// F7.
    case f7
    /// F8.
    case f8
    /// F9.
    case f9
    /// F10.
    case f10
    /// F11.
    case f11
    /// F12.
    case f12
    /// F13.
    case f13
    /// F14.
    case f14
    /// F15.
    case f15
    /// F16.
    case f16
    /// F17.
    case f17
    /// F18.
    case f18
    /// F19.
    case f19
    /// F20.
    case f20
    /// Volume down (different from F11).
    case volumeDown
    /// Volume up (different from F12).
    case volumeUp
    /// Mute (different from F10).
    case mute

    /// Unidentified.
    case unidentifiedCode42
    /// Unidentified.
    case unidentifiedCode46
    /// Unidentified.
    case unidentifiedCode4D

    // MARK: - Key Codes

    #if canImport(Carbon)
    private static let codeMapping: BijectiveMapping<Key, Int> = [

        .leftOutsideTopISO: kVK_ISO_Section,
        .leftLittleTop: kVK_ANSI_1,
        .leftRingTop: kVK_ANSI_2,
        .leftMiddleTop: kVK_ANSI_3,
        .leftIndexTop: kVK_ANSI_4,
        .leftInsideTop: kVK_ANSI_5,
        .rightInsideTop: kVK_ANSI_6,
        .rightIndexTop: kVK_ANSI_7,
        .rightMiddleTop: kVK_ANSI_8,
        .rightRingTop: kVK_ANSI_9,
        .rightLittleTop: kVK_ANSI_0,
        .rightOutsideTop: kVK_ANSI_Minus,
        .rightDoubleOutsideTop: kVK_ANSI_Equal,
        .rightTripleOutsideTopJIS: kVK_JIS_Yen,
        .deleteBackspace: kVK_Delete,

        .tabulation: kVK_Tab,
        .leftLittleUpper: kVK_ANSI_Q,
        .leftRingUpper: kVK_ANSI_W,
        .leftMiddleUpper: kVK_ANSI_E,
        .leftIndexUpper: kVK_ANSI_R,
        .leftInsideUpper: kVK_ANSI_T,
        .rightInsideUpper: kVK_ANSI_Y,
        .rightIndexUpper: kVK_ANSI_U,
        .rightMiddleUpper: kVK_ANSI_I,
        .rightRingUpper: kVK_ANSI_O,
        .rightLittleUpper: kVK_ANSI_P,
        .rightOutsideUpper: kVK_ANSI_LeftBracket,
        .rightDoubleOutsideUpper: kVK_ANSI_RightBracket,

        .capsLockLeftHomeISO_ANSI_CapsLockRightBottomJIS: kVK_CapsLock,
        .leftLittleHome: kVK_ANSI_A,
        .leftRingHome: kVK_ANSI_S,
        .leftMiddleHome: kVK_ANSI_D,
        .leftIndexHome: kVK_ANSI_F,
        .leftInsideHome: kVK_ANSI_G,
        .rightInsideHome: kVK_ANSI_H,
        .rightIndexHome: kVK_ANSI_J,
        .rightMiddleHome: kVK_ANSI_K,
        .rightRingHome: kVK_ANSI_L,
        .rightLittleHome: kVK_ANSI_Semicolon,
        .rightOutsideHome: kVK_ANSI_Quote,
        .rightDoubleOutsideHomeISO_JIS_RightTripleOutsideUpperANSI: kVK_ANSI_Backslash,
        .return: kVK_Return,

        .shiftLeft: kVK_Shift,
        .leftOutsideLowerISO_LeftOutsideTopANSI_JIS: kVK_ANSI_Grave,
        .leftLittleLower: kVK_ANSI_Z,
        .leftRingLower: kVK_ANSI_X,
        .leftMiddleLower: kVK_ANSI_C,
        .leftIndexLower: kVK_ANSI_V,
        .leftInsideLower: kVK_ANSI_B,
        .rightInsideLower: kVK_ANSI_N,
        .rightIndexLower: kVK_ANSI_M,
        .rightMiddleLower: kVK_ANSI_Comma,
        .rightRingLower: kVK_ANSI_Period,
        .rightLittleLower: kVK_ANSI_Slash,
        .rightOutsideLowerJIS: kVK_JIS_Underscore,
        .shiftRight: kVK_RightShift,

        .function: kVK_Function,
        .controlLeftBottomISO_ANSI_ControlLeftHomeJIS: kVK_Control,
        .optionLeft: kVK_Option,
        .commandLeft: kVK_Command,
        .英数ジス: kVK_JIS_Eisu,
        .thumbs: kVK_Space,
        .かなジス: kVK_JIS_Kana,
        .commandRight: 0x36,
        .optionRight: kVK_RightOption,
        .controlRightISO_ANSI: kVK_RightControl,


        .help: kVK_Help,
        .home: kVK_Home,
        .pageUp: kVK_PageUp,

        .deleteForward: kVK_ForwardDelete,
        .end: kVK_End,
        .pageDown: kVK_PageDown,

        .arrowUp: kVK_UpArrow,
        .arrowLeft: kVK_LeftArrow,
        .arrowDown: kVK_DownArrow,
        .arrowRight: kVK_RightArrow,


        .clear: kVK_ANSI_KeypadClear,
        .padMiddleTopMac: kVK_ANSI_KeypadEquals,
        .padRingTopMac_padMiddleTopPC: kVK_ANSI_KeypadDivide,
        .padLittleTopMac_padRingTopPC: kVK_ANSI_KeypadMultiply,

        .padIndexUpper: kVK_ANSI_Keypad7,
        .padMiddleUpper: kVK_ANSI_Keypad8,
        .padRingUpper: kVK_ANSI_Keypad9,
        .padLittleUpperMac_padLittleTopPC: kVK_ANSI_KeypadMinus,

        .padIndexHome: kVK_ANSI_Keypad4,
        .padMiddleHome: kVK_ANSI_Keypad5,
        .padRingHome: kVK_ANSI_Keypad6,
        .padLittleHome: kVK_ANSI_KeypadPlus,

        .padIndexLower: kVK_ANSI_Keypad1,
        .padMiddleLower: kVK_ANSI_Keypad2,
        .padRingLower: kVK_ANSI_Keypad3,
        .enterPad: kVK_ANSI_KeypadEnter,

        .padThumb: kVK_ANSI_Keypad0,
        .padMiddleBottomJIS: kVK_JIS_KeypadComma,
        .padRingBottom: kVK_ANSI_KeypadDecimal,


        .escape: kVK_Escape,
        .f1: kVK_F1,
        .f2: kVK_F2,
        .f3: kVK_F3,
        .f4: kVK_F4,
        .f5: kVK_F5,
        .f6: kVK_F6,
        .f7: kVK_F7,
        .f8: kVK_F8,
        .f9: kVK_F9,
        .f10: kVK_F10,
        .f11: kVK_F11,
        .f12: kVK_F12,
        .f13: kVK_F13,
        .f14: kVK_F14,
        .f15: kVK_F15,
        .f16: kVK_F16,
        .f17: kVK_F17,
        .f18: kVK_F18,
        .f19: kVK_F19,
        .f20: kVK_F20,

        .volumeDown: kVK_VolumeDown,
        .volumeUp: kVK_VolumeUp,
        .mute: kVK_Mute,

        .unidentifiedCode42: 0x42,
        .unidentifiedCode46: 0x46,
        .unidentifiedCode4D: 0x4D,
        ]
    #endif

    // MARK: - Initialization

    #if canImport(Carbon)
    /// Creates a `Key` from a `CGKeyCode`.
    ///
    /// - Parameters:
    ///     - code: The `CGKeyCode`.
    public init?(code: CGKeyCode) {
        if let key = Key.codeMapping[Int(code)] {
            self = key
        } else {
            return nil
        }
    }
    #endif

    // MARK: - Properties

    #if canImport(Carbon)
    /// The CGKeyCode for `self`.
    public var keyCode: CGKeyCode {
        return CGKeyCode(Key.codeMapping[self]!)
    }
    #endif

    /// Returns `true` if `self` is located in the same position on every hardware layout.
    public var hasConsistentPosition: Bool {
        switch self {
        case .leftLittleTop, .leftRingTop, .leftMiddleTop, .leftIndexTop, .leftInsideTop, .rightInsideTop, .rightIndexTop, .rightMiddleTop, .rightRingTop, .rightLittleTop, .rightOutsideTop, .rightDoubleOutsideTop, .deleteBackspace, .tabulation, .leftLittleUpper, .leftRingUpper, .leftMiddleUpper, .leftIndexUpper, .leftInsideUpper, .rightInsideUpper, .rightIndexUpper, .rightMiddleUpper, .rightRingUpper, .rightLittleUpper, .rightOutsideUpper, .rightDoubleOutsideUpper, .leftLittleHome, .leftRingHome, .leftMiddleHome, .leftIndexHome, .leftInsideHome, .rightInsideHome, .rightIndexHome, .rightMiddleHome, .rightRingHome, .rightLittleHome, .rightOutsideHome, .return, .shiftLeft, .leftLittleLower, .leftRingLower, .leftMiddleLower, .leftIndexLower, .leftInsideLower, .rightInsideLower, .rightIndexLower, .rightMiddleLower, .rightRingLower, .rightLittleLower, .shiftRight, .optionLeft, .commandLeft, .thumbs, .commandRight, .optionRight, .arrowUp, .arrowLeft, .arrowDown, .arrowRight, .escape, .f1, .f2, .f3, .f4, .f5, .f6, .f7, .f8, .f9, .f10, .f11, .f12:
            return true
        default:
            return false
        }
    }

    /// Returns `true` if self is present on every hardware layout (but not necessarily in the same location).
    public var existsConsistently: Bool {
        if hasConsistentPosition {
            return true
        } else {
            switch self {
            case .capsLockLeftHomeISO_ANSI_CapsLockRightBottomJIS, .rightDoubleOutsideHomeISO_JIS_RightTripleOutsideUpperANSI, .leftOutsideLowerISO_LeftOutsideTopANSI_JIS, .controlLeftBottomISO_ANSI_ControlLeftHomeJIS:
                return true
            default:
                return false
            }
        }
    }

    // MARK: - Usage

    #if canImport(Carbon)
    /// Returns the character printed on the physical key. This is useful for describing controls to the user.
    ///
    /// - Note: This is accomplished by determining the key’s output, and modifing it to match keyboard labelling conventions (such as printing letters uppercase). Therefore, if the user’s virtual and physical keyboards do not match, the returned string will match the virtual layout, not the physical one.
    ///
    /// - Note: This method is known to fail upon encountering a dead key. In this case, it will return an empty string.
    ///
    /// - Returns: The character printed on the key.
    public var currentName: StrictString {
        let output = self.output(with: CGEventFlags(rawValue: 0))

        if output.scalars.contains(where: { $0.properties.changesWhenUppercased }) {
            let shifted = self.output(with: .maskShift)

            if shifted.lowercased() == output
                ∨ output.uppercased() == shifted { // @exempt(from: tests) Reachability depends on keyboard.
                return StrictString(shifted)
            } else if output == "i" ∧ shifted == "İ" { // @exempt(from: tests)
                // Turkic
                return StrictString(shifted)
            } else if output == "ĸ" ∧ shifted == "Kʻ" { // @exempt(from: tests)
                // Inuktitut
                return StrictString(shifted)
            }
        }

        return StrictString(output)
    }

    private func output(with modifiers: CGEventFlags) -> String {
        let keyboard = TISCopyCurrentKeyboardLayoutInputSource().takeRetainedValue()
        let rawLayoutData = TISGetInputSourceProperty(keyboard, kTISPropertyUnicodeKeyLayoutData)
        let layoutData = unsafeBitCast(rawLayoutData, to: CFData.self)
        let layout: UnsafePointer<UCKeyboardLayout> = unsafeBitCast(
            CFDataGetBytePtr(layoutData),
            to: UnsafePointer<UCKeyboardLayout>.self)
        let action = UInt16(kUCKeyActionDisplay)
        let modifierKeyState = UInt32((modifiers.rawValue >> 16) & 0xFF)
        let keyboardType = UInt32(LMGetKbdType())
        let keyTranslateOptions = OptionBits(kUCKeyTranslateNoDeadKeysBit)
        var deadKeyState: UInt32 = 0
        let maxStringLength = 255
        var actualStringLength = 0
        var result = [UniChar](repeating: 0, count: maxStringLength)

        _ = UCKeyTranslate(
            layout,
            keyCode,
            action,
            modifierKeyState,
            keyboardType,
            keyTranslateOptions,
            &deadKeyState,
            maxStringLength,
            &actualStringLength,
            &result)

        return NSString(characters: result, length: actualStringLength) as String
    }
    #endif
}
