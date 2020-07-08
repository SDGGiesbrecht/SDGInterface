

cmake_minimum_required(VERSION 3.15)

project("SDGInterface" LANGUAGES Swift)

include(CTest)

set(CMAKE_Swift_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/swift)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

option(BUILD_SHARED_LIBS "Use dynamic linking" YES)

add_library("SDGControlFlow"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/APILocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/Assert.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/Caching.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/Decodable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/DefaultAssignmentPropertyWrapper.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/Encodable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/Memory.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/NonmutatingVariants.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/ProjectingPropertyWrapper.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/PropertyWrapper.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/Shared.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/SharedProperty.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/SharedValueObserver.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/TextualPlaygroundDisplay.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/TransparentWrapper.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/Weak.swift"
)
set_target_properties("SDGControlFlow" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGControlFlow" PRIVATE -enable-testing)

add_library("SDGLogic"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLogic/Any.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLogic/Bool.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLogic/Equatable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLogic/NilLiteral.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLogic/Operators.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLogic/Tuple.swift"
)
set_target_properties("SDGLogic" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGLogic" PRIVATE -enable-testing)

add_library("SDGMathematics"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Angle.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/BitField.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/ClosedRange.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Comparable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Data.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Float.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/FunctionAnalysis.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Int.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Measurement.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/Addable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/FixedScaleOneDimensionalPoint.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/GenericAdditiveArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/IntegerProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/IntegralArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/Negatable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/NumericAdditiveArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/OneDimensionalPoint.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/OneDimensionalVector.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/PointProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/RationalArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/RationalNumberProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/RationalVector.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/RealArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/RealNumberProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/Subtractable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/VectorProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/WholeArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/WholeNumberProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Operators.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/OrderedEnumeration.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Sequence.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Tuple.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/UInt.swift"
)
set_target_properties("SDGMathematics" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGMathematics" PRIVATE -enable-testing)
target_link_libraries("SDGMathematics" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
)

add_library("SDGCollections"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Addable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Associative/BijectiveMapping.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Associative/ContextualMapping.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Associative/Dictionary.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Conformances/CharacterSet.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Conformances/Data.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Conformances/String.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/LegacyMode.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Operators.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/AnyCollection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Array.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/BidirectionalCollection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Collection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/CollectionDifference.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/CollectionDifferenceChange.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/FillDirection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/AlternativePatterns.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/AnyPattern.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/ConcatenatedPatterns.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/ConditionalPattern.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/NaryAlternativePatterns.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/NaryConcatenatedPatterns.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/NegatedPattern.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/NestingLevel.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/Pattern.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/PatternConsumption.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/PatternMatch.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/RepetitionPattern.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Range.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/RangeExpression.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/RangeReplaceableCollection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/ReversedCollection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/SearchableBidirectionalCollection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/SearchableCollection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Slice.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/AbsoluteComplement.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/ComparableSet.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/FiniteSet.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/IntensionalSet.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/Intersection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/MutableSet.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/Set.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/SetDefinition.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/SetInRepresentableUniverse.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/Union.swift"
)
set_target_properties("SDGCollections" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGCollections" PRIVATE -enable-testing)
target_link_libraries("SDGCollections" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
)

add_library("SDGGeometry"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGGeometry/Angle.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGGeometry/BezierPath.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGGeometry/CGPoint.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGGeometry/CGVector.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGGeometry/TwoDimensionalPoint.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGGeometry/TwoDimensionalPointProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGGeometry/TwoDimensionalVector.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGGeometry/TwoDimensionalVectorProtocol.swift"
)
set_target_properties("SDGGeometry" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGGeometry" PRIVATE -enable-testing)
target_link_libraries("SDGGeometry" PRIVATE
  "SDGControlFlow"
  "SDGMathematics"
)

add_library("SDGText"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/CharacterSet.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/CollectionStringFamily.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/CollectionUnicodeScalar.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Compatibility/StaticString.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Compatibility/String.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Compatibility/StringClusterView.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Compatibility/StringScalarView.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/ExtendedGraphemeCluster.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Font/Font.Definition.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Font/Font.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Font/NSFont.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Font/SwiftUI.Font.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Font/UIFont.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/MarkupPlaygroundDisplay.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Range.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/SemanticMarkup.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/SemanticMarkupStringInterpolation.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Strict/StrictString.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Strict/StrictStringClusterView.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Strict/StrictStringInterpolationProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Strict/StrictStringStringInterpolation.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/ExtendedGraphemeClusterView.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/Line.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/LineView.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/LineViewIndex.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/NewlinePattern.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/StringFamily.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/StringIndex.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/UnicodeScalarView.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/UnicodeScalar.swift"
)
set_target_properties("SDGText" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGText" PRIVATE -enable-testing)
target_link_libraries("SDGText" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
)

add_library("SDGPersistence"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/Data.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/FileConvertible.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/FileManager.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/Preference.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/PreferenceSet.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/ProcessInfo.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/StrictString.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/String.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/URL.swift"
)
set_target_properties("SDGPersistence" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGPersistence" PRIVATE -enable-testing)
target_link_libraries("SDGPersistence" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
)

add_library("SDGLocalization"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/CachedLocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Bool.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Decodable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/LosslessStringConvertible.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/Angle.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/Float.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/Int.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/IntegerProtcool.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/IntegralArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/RationalArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/RationalNumberProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/UInt.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/WholeArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/WholeNumberProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Precondition.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/PresentableError.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Range.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/TextConvertibleNumber.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/TextConvertibleNumberParseError.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/InputLocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Interpolation/Casing.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Interpolation/EnglishCasing.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Interpolation/GenreGrammatical.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Interpolation/GrammaticalGender.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Interpolation/GrammaticalNumber.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Interpolation/GrammatikiPtosi.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Localization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/LocalizationSetting.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/LocalizationSettingStabilizationMode.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Localizations/APILocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Localizations/AnyLocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Localizations/ContentLocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Localizations/FormatLocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Localizations/InterfaceLocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Metadata/Language.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Metadata/LocalizationData.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Metadata/Script.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Metadata/State.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Metadata/StateData.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Metadata/TextDirection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/UserFacing.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/UserFacingDynamic.swift"
)
set_target_properties("SDGLocalization" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGLocalization" PRIVATE -enable-testing)
target_link_libraries("SDGLocalization" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGPersistence"
)

add_library("SDGCornerstoneLocalizations"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCornerstoneLocalizations/APILocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCornerstoneLocalizations/FormatLocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCornerstoneLocalizations/InterfaceLocalization.swift"
)
set_target_properties("SDGCornerstoneLocalizations" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGCornerstoneLocalizations" PRIVATE -enable-testing)
target_link_libraries("SDGCornerstoneLocalizations" PRIVATE
  "SDGControlFlow"
  "SDGLocalization"
)

add_library("SDGCalendar"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/CalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/CardinalCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/ConsistentDurationCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/ConsistentlyOrderedCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/Day.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/EnumerationCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/ICalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/ISOCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/Month.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/NumericCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/OrdinalCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/RawRepresentableCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/SmallestCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/Weekday.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/Year.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/AnyDescribableDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/CalendarDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/CalendarInterval.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Date.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/DateDefinition.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/DescribableDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/FoundationDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianDay.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianHour.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianMinute.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianMonth.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianSecond.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianWeekday.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianWeekdayDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianYear.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewDay.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewHour.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewMonth.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewMonthAndYear.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewPart.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewWeekday.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewWeekdayDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewYear.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewYearLength.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/RationalArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/RelativeDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/UnknownDate.swift"
)
set_target_properties("SDGCalendar" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGCalendar" PRIVATE -enable-testing)
target_link_libraries("SDGCalendar" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
  "SDGCornerstoneLocalizations"
)

add_library("SDGTesting"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGTesting/PerformanceTest.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGTesting/Test.swift"
)
set_target_properties("SDGTesting" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGTesting" PRIVATE -enable-testing)
target_link_libraries("SDGTesting" PRIVATE
  "SDGControlFlow"
  "SDGMathematics"
  "SDGText"
  "SDGLocalization"
  "SDGCornerstoneLocalizations"
)

add_library("SDGLogicTestUtilities"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLogicTestUtilities/Equatable.swift"
)
set_target_properties("SDGLogicTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGLogicTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGLogicTestUtilities" PRIVATE
  "SDGLogic"
  "SDGTesting"
)

add_library("SDGPersistenceTestUtilities"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistenceTestUtilities/Codable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistenceTestUtilities/FileConvertible.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistenceTestUtilities/Specification.swift"
)
set_target_properties("SDGPersistenceTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGPersistenceTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGPersistenceTestUtilities" PRIVATE
  "SDGPersistence"
  "SDGTesting"
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
  "SDGCalendar"
  "SDGCornerstoneLocalizations"
)

add_library("SDGLocalizationTestUtilities"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalizationTestUtilities/CustomStringConvertible.swift"
)
set_target_properties("SDGLocalizationTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGLocalizationTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGLocalizationTestUtilities" PRIVATE
  "SDGLocalization"
  "SDGTesting"
  "SDGText"
  "SDGPersistence"
  "SDGPersistenceTestUtilities"
)

add_library("SDGXCTestUtilities"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGXCTestUtilities/TestCase.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGXCTestUtilities/XCTAssert.swift"
)
set_target_properties("SDGXCTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGXCTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGXCTestUtilities" PRIVATE
  "SDGTesting"
  "SDGLogic"
  "SDGMathematics"
  "SDGText"
  "SDGPersistence"
)

add_library("SDGInterfaceLocalizations"
  "../../../Sources/SDGInterfaceLocalizations/APILocalization.swift"
  "../../../Sources/SDGInterfaceLocalizations/InterfaceLocalization.swift"
  "../../../Sources/SDGInterfaceLocalizations/MenuBarLocalization.swift"
)
set_target_properties("SDGInterfaceLocalizations" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGInterfaceLocalizations" PRIVATE -enable-testing)
target_link_libraries("SDGInterfaceLocalizations" PRIVATE
  "SDGLocalization"
)

add_library("SDGErrorMessages"
  "../../../Sources/SDGErrorMessages/Error.swift"
  "../../../Sources/SDGErrorMessages/Windows.swift"
)
set_target_properties("SDGErrorMessages" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGErrorMessages" PRIVATE -enable-testing)
target_link_libraries("SDGErrorMessages" PRIVATE
  "SDGInterfaceLocalizations"
  "SDGText"
  "SDGLocalization"
)

add_library("SDGInterfaceBasics"
  "../../../Sources/SDGInterfaceBasics/Application Name/ApplicationNameForm.swift"
  "../../../Sources/SDGInterfaceBasics/Application Name/ApplicationNameLocalization.swift"
  "../../../Sources/SDGInterfaceBasics/Binding.swift"
  "../../../Sources/SDGInterfaceBasics/Colour/Colour.swift"
  "../../../Sources/SDGInterfaceBasics/Colour/NSColor.swift"
  "../../../Sources/SDGInterfaceBasics/Colour/UIColor.swift"
  "../../../Sources/SDGInterfaceBasics/Font.swift"
  "../../../Sources/SDGInterfaceBasics/Layout Basics/Alignment/Alignment.swift"
  "../../../Sources/SDGInterfaceBasics/Layout Basics/Alignment/HorizontalAlignment.swift"
  "../../../Sources/SDGInterfaceBasics/Layout Basics/Alignment/VerticalAlignment.swift"
  "../../../Sources/SDGInterfaceBasics/Layout Basics/ContentMode.swift"
  "../../../Sources/SDGInterfaceBasics/Layout Basics/Edge/Edge.swift"
  "../../../Sources/SDGInterfaceBasics/Layout Basics/Edge/EdgeSet.swift"
  "../../../Sources/SDGInterfaceBasics/Layout Basics/Point/CGPoint.swift"
  "../../../Sources/SDGInterfaceBasics/Layout Basics/Point/Point.swift"
  "../../../Sources/SDGInterfaceBasics/Layout Basics/Rectangle/CGRect.swift"
  "../../../Sources/SDGInterfaceBasics/Layout Basics/Rectangle/Rectangle.swift"
  "../../../Sources/SDGInterfaceBasics/Layout Basics/Size/CGSize.swift"
  "../../../Sources/SDGInterfaceBasics/Layout Basics/Size/Size.swift"
  "../../../Sources/SDGInterfaceBasics/ProcessInfo.swift"
  "../../../Sources/SDGInterfaceBasics/Text Primitives/FieldEditor.swift"
  "../../../Sources/SDGInterfaceBasics/Text Primitives/RichTextEditingResponder.swift"
  "../../../Sources/SDGInterfaceBasics/Text Primitives/TextDisplayResponder.swift"
  "../../../Sources/SDGInterfaceBasics/Text Primitives/TextEditingResponder.swift"
)
set_target_properties("SDGInterfaceBasics" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGInterfaceBasics" PRIVATE -enable-testing)
target_link_libraries("SDGInterfaceBasics" PRIVATE
  "SDGInterfaceLocalizations"
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
  "SDGGeometry"
)

add_library("SDGKeyboard"
  "../../../Sources/SDGKeyboard/Key.swift"
)
set_target_properties("SDGKeyboard" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGKeyboard" PRIVATE -enable-testing)
target_link_libraries("SDGKeyboard" PRIVATE
  "SDGLogic"
  "SDGCollections"
  "SDGText"
)

add_library("SDGMenus"
  "../../../Sources/SDGMenus/AnyMenu.swift"
  "../../../Sources/SDGMenus/AnyMenuEntry.swift"
  "../../../Sources/SDGMenus/KeyModifiers.swift"
  "../../../Sources/SDGMenus/Menu.swift"
  "../../../Sources/SDGMenus/MenuBindingObserver.swift"
  "../../../Sources/SDGMenus/MenuComponent.swift"
  "../../../Sources/SDGMenus/MenuEntry.swift"
  "../../../Sources/SDGMenus/MenuEntryBindingObserver.swift"
  "../../../Sources/SDGMenus/Selector.swift"
)
set_target_properties("SDGMenus" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGMenus" PRIVATE -enable-testing)
target_link_libraries("SDGMenus" PRIVATE
  "SDGInterfaceBasics"
  "SDGInterfaceLocalizations"
  "SDGControlFlow"
  "SDGText"
  "SDGLocalization"
)

add_library("SDGContextMenu"
  "../../../Sources/SDGContextMenu/ContextMenu.swift"
  "../../../Sources/SDGContextMenu/ContextMenuEntries.swift"
)
set_target_properties("SDGContextMenu" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGContextMenu" PRIVATE -enable-testing)
target_link_libraries("SDGContextMenu" PRIVATE
  "SDGMenus"
  "SDGInterfaceLocalizations"
  "SDGLogic"
  "SDGText"
  "SDGLocalization"
)

add_library("SDGMenuBar"
  "../../../Sources/SDGMenuBar/MenuBar.swift"
  "../../../Sources/SDGMenuBar/MenuBarApplication.swift"
  "../../../Sources/SDGMenuBar/MenuBarEdit.swift"
  "../../../Sources/SDGMenuBar/MenuBarEditFind.swift"
  "../../../Sources/SDGMenuBar/MenuBarEditSpeech.swift"
  "../../../Sources/SDGMenuBar/MenuBarEditSpellingAndGrammar.swift"
  "../../../Sources/SDGMenuBar/MenuBarEditSubstitutions.swift"
  "../../../Sources/SDGMenuBar/MenuBarEditTransformations.swift"
  "../../../Sources/SDGMenuBar/MenuBarFile.swift"
  "../../../Sources/SDGMenuBar/MenuBarFileOpenRecent.swift"
  "../../../Sources/SDGMenuBar/MenuBarFormat.swift"
  "../../../Sources/SDGMenuBar/MenuBarFormatFont.swift"
  "../../../Sources/SDGMenuBar/MenuBarFormatFontBaseline.swift"
  "../../../Sources/SDGMenuBar/MenuBarFormatFontCasing.swift"
  "../../../Sources/SDGMenuBar/MenuBarFormatFontKern.swift"
  "../../../Sources/SDGMenuBar/MenuBarFormatFontLigatures.swift"
  "../../../Sources/SDGMenuBar/MenuBarFormatText.swift"
  "../../../Sources/SDGMenuBar/MenuBarFormatTextWritingDirection.swift"
  "../../../Sources/SDGMenuBar/MenuBarHelp.swift"
  "../../../Sources/SDGMenuBar/MenuBarView.swift"
  "../../../Sources/SDGMenuBar/MenuBarWindow.swift"
  "../../../Sources/SDGMenuBar/NSApplicationDelegateProtocol.swift"
  "../../../Sources/SDGMenuBar/Selector.swift"
  "../../../Sources/SDGMenuBar/Windows.swift"
)
set_target_properties("SDGMenuBar" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGMenuBar" PRIVATE -enable-testing)
target_link_libraries("SDGMenuBar" PRIVATE
  "SDGInterfaceBasics"
  "SDGMenus"
  "SDGContextMenu"
  "SDGInterfaceLocalizations"
  "SDGMathematics"
  "SDGText"
  "SDGLocalization"
)

add_library("SDGApplication"
  "../../../Sources/SDGApplication/Application/Application.swift"
  "../../../Sources/SDGApplication/Application/NSApplicationDelegate.swift"
  "../../../Sources/SDGApplication/Application/PreferenceManager.swift"
  "../../../Sources/SDGApplication/Application/System Mediator/ExtensionDetails.swift"
  "../../../Sources/SDGApplication/Application/System Mediator/FetchResult.swift"
  "../../../Sources/SDGApplication/Application/System Mediator/Handoff.swift"
  "../../../Sources/SDGApplication/Application/System Mediator/HandoffAcceptanceDetails.swift"
  "../../../Sources/SDGApplication/Application/System Mediator/LaunchDetails.swift"
  "../../../Sources/SDGApplication/Application/System Mediator/OpeningDetails.swift"
  "../../../Sources/SDGApplication/Application/System Mediator/PrintingDetails.swift"
  "../../../Sources/SDGApplication/Application/System Mediator/PrintingResponse.swift"
  "../../../Sources/SDGApplication/Application/System Mediator/QuickActionDetails.swift"
  "../../../Sources/SDGApplication/Application/System Mediator/RemoteNotificationDetails.swift"
  "../../../Sources/SDGApplication/Application/System Mediator/SystemMediator.swift"
  "../../../Sources/SDGApplication/Application/System Mediator/SystemNotification.swift"
  "../../../Sources/SDGApplication/Application/System Mediator/TerminationResponse.swift"
  "../../../Sources/SDGApplication/Application/System Mediator/ViewControllerRestorationResponse.swift"
  "../../../Sources/SDGApplication/Application/UIApplicationDelegate.swift"
  "../../../Sources/SDGApplication/ProcessInfo.swift"
)
set_target_properties("SDGApplication" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGApplication" PRIVATE -enable-testing)
target_link_libraries("SDGApplication" PRIVATE
  "SDGInterfaceLocalizations"
  "SDGMenus"
  "SDGContextMenu"
  "SDGMenuBar"
  "SDGLogic"
  "SDGText"
  "SDGLocalization"
  "SDGCalendar"
)

add_library("SDGViews"
  "../../../Sources/SDGViews/AnyView.swift"
  "../../../Sources/SDGViews/Axis.swift"
  "../../../Sources/SDGViews/Cocoa/CocoaView.swift"
  "../../../Sources/SDGViews/Cocoa/LayoutConstraintPriority.NativeType.swift"
  "../../../Sources/SDGViews/Cocoa/LayoutConstraintPriority.swift"
  "../../../Sources/SDGViews/Colour.swift"
  "../../../Sources/SDGViews/ColourContainer.swift"
  "../../../Sources/SDGViews/EmptyView.swift"
  "../../../Sources/SDGViews/HorizontalStack.swift"
  "../../../Sources/SDGViews/Layout/Framed.swift"
  "../../../Sources/SDGViews/Layout/Layered.swift"
  "../../../Sources/SDGViews/Layout/Padded.swift"
  "../../../Sources/SDGViews/Layout/Proportioned.swift"
  "../../../Sources/SDGViews/LegacyMode.swift"
  "../../../Sources/SDGViews/Preview Utilities/Previews.swift"
  "../../../Sources/SDGViews/Previews/AspectRatioPreviews.swift"
  "../../../Sources/SDGViews/Previews/BackgroundPreviews.swift"
  "../../../Sources/SDGViews/Previews/FramePreviews.swift"
  "../../../Sources/SDGViews/Previews/HorizontalStackPreviews.swift"
  "../../../Sources/SDGViews/Previews/LetterboxPreviews.swift"
  "../../../Sources/SDGViews/Previews/PaddingPreviews.swift"
  "../../../Sources/SDGViews/Protocol/CocoaViewImplementation.swift"
  "../../../Sources/SDGViews/Protocol/CocoaViewRepresentableWrapper.swift"
  "../../../Sources/SDGViews/Protocol/LegacyView.swift"
  "../../../Sources/SDGViews/Protocol/SwiftUIViewImplementation.swift"
  "../../../Sources/SDGViews/Protocol/View.swift"
  "../../../Sources/SDGViews/Protocol/ViewProtocolShims.swift"
  "../../../Sources/SDGViews/SwiftUI/Color.swift"
  "../../../Sources/SDGViews/SwiftUI/Ellipse.swift"
  "../../../Sources/SDGViews/SwiftUI/Rectangle.swift"
  "../../../Sources/SDGViews/SwiftUI/SwiftUIAnyView.swift"
  "../../../Sources/SDGViews/SwiftUI/SwiftUITupleView.swift"
)
set_target_properties("SDGViews" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGViews" PRIVATE -enable-testing)
target_link_libraries("SDGViews" PRIVATE
  "SDGInterfaceBasics"
  "SDGInterfaceLocalizations"
  "SDGLogic"
  "SDGMathematics"
  "SDGText"
  "SDGCollections"
  "SDGLocalization"
)

add_library("SDGImageDisplay"
  "../../../Sources/SDGImageDisplay/Cocoa/CocoaImage.swift"
  "../../../Sources/SDGImageDisplay/Image.Definition.swift"
  "../../../Sources/SDGImageDisplay/Image.swift"
  "../../../Sources/SDGImageDisplay/LegacyMode.swift"
  "../../../Sources/SDGImageDisplay/LegacyView.swift"
  "../../../Sources/SDGImageDisplay/Previews/ImagePreview.swift"
  "../../../Sources/SDGImageDisplay/Previews/Previews.swift"
  "../../../Sources/SDGImageDisplay/SwiftUI/SwiftUI.Image.swift"
  "../../../Sources/SDGImageDisplay/View.swift"
  "../../../Sources/SDGImageDisplay/Windows.swift"
)
set_target_properties("SDGImageDisplay" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGImageDisplay" PRIVATE -enable-testing)
target_link_libraries("SDGImageDisplay" PRIVATE
  "SDGViews"
)

add_library("SDGPopOvers"
  "../../../Sources/SDGPopOvers/CocoaPopOverView.swift"
  "../../../Sources/SDGPopOvers/PopOverDelegate.swift"
  "../../../Sources/SDGPopOvers/UIView.swift"
  "../../../Sources/SDGPopOvers/View.swift"
  "../../../Sources/SDGPopOvers/Windows.swift"
)
set_target_properties("SDGPopOvers" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGPopOvers" PRIVATE -enable-testing)
target_link_libraries("SDGPopOvers" PRIVATE
  "SDGInterfaceBasics"
  "SDGViews"
  "SDGLogic"
)

add_library("SDGTables"
  "../../../Sources/SDGTables/Table.CocoaImplementation/NSTableViewDelegate.swift"
  "../../../Sources/SDGTables/Table.CocoaImplementation/Table.CocoaImplementation.CellView.swift"
  "../../../Sources/SDGTables/Table.CocoaImplementation/Table.CocoaImplementation.TableView.swift"
  "../../../Sources/SDGTables/Table.CocoaImplementation/Table.CocoaImplementation.swift"
  "../../../Sources/SDGTables/Table.CocoaImplementation/UITableViewCell.swift"
  "../../../Sources/SDGTables/Table.CocoaImplementation/UITableViewDataSource.swift"
  "../../../Sources/SDGTables/Table.swift"
  "../../../Sources/SDGTables/Windows.swift"
)
set_target_properties("SDGTables" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGTables" PRIVATE -enable-testing)
target_link_libraries("SDGTables" PRIVATE
  "SDGViews"
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
)

add_library("SDGWindows"
  "../../../Sources/SDGWindows/AnyWindow.swift"
  "../../../Sources/SDGWindows/BindingObserver.swift"
  "../../../Sources/SDGWindows/FullscreenObserver.swift"
  "../../../Sources/SDGWindows/NSWindowDelegate.swift"
  "../../../Sources/SDGWindows/Window.swift"
  "../../../Sources/SDGWindows/Windows.swift"
)
set_target_properties("SDGWindows" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGWindows" PRIVATE -enable-testing)
target_link_libraries("SDGWindows" PRIVATE
  "SDGInterfaceBasics"
  "SDGViews"
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGText"
  "SDGLocalization"
  "SDGGeometry"
)

add_library("SDGTextDisplay"
  "../../../Sources/SDGTextDisplay/AnyLabel.swift"
  "../../../Sources/SDGTextDisplay/CharacterInformation.swift"
  "../../../Sources/SDGTextDisplay/CocoaTextField.swift"
  "../../../Sources/SDGTextDisplay/FieldEditor.swift"
  "../../../Sources/SDGTextDisplay/Label.swift"
  "../../../Sources/SDGTextDisplay/LabelBindingObserver.swift"
  "../../../Sources/SDGTextDisplay/LabelledTextField.swift"
  "../../../Sources/SDGTextDisplay/NSUITextView.swift"
  "../../../Sources/SDGTextDisplay/Resources.swift"
  "../../../Sources/SDGTextDisplay/Rich Text/NSAttributedString.Key.swift"
  "../../../Sources/SDGTextDisplay/Rich Text/NSAttributedString.swift"
  "../../../Sources/SDGTextDisplay/Rich Text/RichText.swift"
  "../../../Sources/SDGTextDisplay/Rich Text/RichTextIndex.swift"
  "../../../Sources/SDGTextDisplay/Rich Text/RichTextNormalizationAttribute.swift"
  "../../../Sources/SDGTextDisplay/Rich Text/RichTextNormalizationAttributeMapping.swift"
  "../../../Sources/SDGTextDisplay/Rich Text/RichTextScalar.swift"
  "../../../Sources/SDGTextDisplay/Rich Text/RichTextSegment.swift"
  "../../../Sources/SDGTextDisplay/TextContextMenu.swift"
  "../../../Sources/SDGTextDisplay/TextEditor.swift"
  "../../../Sources/SDGTextDisplay/TextField.swift"
  "../../../Sources/SDGTextDisplay/TextFieldBindingObserver.swift"
  "../../../Sources/SDGTextDisplay/TextFieldNormalizingCell.swift"
  "../../../Sources/SDGTextDisplay/TextView.swift"
)
set_target_properties("SDGTextDisplay" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGTextDisplay" PRIVATE -enable-testing)
target_link_libraries("SDGTextDisplay" PRIVATE
  "SDGInterfaceBasics"
  "SDGViews"
  "SDGTables"
  "SDGWindows"
  "SDGPopOvers"
  "SDGMenus"
  "SDGContextMenu"
  "SDGInterfaceLocalizations"
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
)

add_library("SDGButtons"
  "../../../Sources/SDGButtons/Button/Button.CocoaImplementation.swift"
  "../../../Sources/SDGButtons/Button/Button.SwiftUIImplementation.swift"
  "../../../Sources/SDGButtons/Button/Button.swift"
  "../../../Sources/SDGButtons/ButtonLabel.swift"
  "../../../Sources/SDGButtons/Check Box/CheckBox.CocoaImplementation.swift"
  "../../../Sources/SDGButtons/Check Box/CheckBox.SwiftUIImplementation.swift"
  "../../../Sources/SDGButtons/Check Box/CheckBox.swift"
  "../../../Sources/SDGButtons/LegacyMode.swift"
  "../../../Sources/SDGButtons/LegacyView.swift"
  "../../../Sources/SDGButtons/Previews/ButtonPreview.swift"
  "../../../Sources/SDGButtons/Previews/CheckBoxPreview.swift"
  "../../../Sources/SDGButtons/Previews/Previews.swift"
  "../../../Sources/SDGButtons/Previews/SegmentedControlPreview.swift"
  "../../../Sources/SDGButtons/SegmentedControl/SegmentedControl.CocoaImplementation.swift"
  "../../../Sources/SDGButtons/SegmentedControl/SegmentedControl.SwiftUIImplementation.swift"
  "../../../Sources/SDGButtons/SegmentedControl/SegmentedControl.swift"
  "../../../Sources/SDGButtons/View.swift"
  "../../../Sources/SDGButtons/Windows.swift"
)
set_target_properties("SDGButtons" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGButtons" PRIVATE -enable-testing)
target_link_libraries("SDGButtons" PRIVATE
  "SDGInterfaceBasics"
  "SDGViews"
  "SDGTextDisplay"
  "SDGImageDisplay"
  "SDGControlFlow"
  "SDGLogic"
  "SDGText"
  "SDGLocalization"
)

add_library("SDGInterfaceResourceGeneration"
  "../../../Tests/SDGInterfaceResourceGeneration/Repository.swift"
  "../../../Tests/SDGInterfaceResourceGeneration/ResourceGeneration.swift"
  "../../../Tests/SDGInterfaceResourceGeneration/RichTextNormalizationAttributeMapping.swift"
)
set_target_properties("SDGInterfaceResourceGeneration" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGInterfaceResourceGeneration" PRIVATE -enable-testing)
target_link_libraries("SDGInterfaceResourceGeneration" PRIVATE
  "SDGTextDisplay"
  "SDGText"
  "SDGLocalization"
  "SDGPersistence"
)

add_library("SDGProgressIndicators"
  "../../../Sources/SDGProgressIndicators/LabelledProgressBar.swift"
  "../../../Sources/SDGProgressIndicators/Previews/ProgressBarPreview.swift"
  "../../../Sources/SDGProgressIndicators/ProgressBar.CocoaImplementation.swift"
  "../../../Sources/SDGProgressIndicators/ProgressBar.swift"
  "../../../Sources/SDGProgressIndicators/Windows.swift"
)
set_target_properties("SDGProgressIndicators" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGProgressIndicators" PRIVATE -enable-testing)
target_link_libraries("SDGProgressIndicators" PRIVATE
  "SDGInterfaceBasics"
  "SDGViews"
  "SDGTextDisplay"
  "SDGControlFlow"
  "SDGMathematics"
  "SDGText"
  "SDGLocalization"
)

add_library("SDGInterfaceSample"
  "../../../Sources/SDGInterfaceSample/Application.swift"
  "../../../Sources/SDGInterfaceSample/InterfaceLocalization.swift"
  "../../../Sources/SDGInterfaceSample/MenuBarSample.swift"
  "../../../Sources/SDGInterfaceSample/MenuBarSampleMenu.swift"
  "../../../Sources/SDGInterfaceSample/MenuBarSampleView.swift"
  "../../../Sources/SDGInterfaceSample/MenuBarSampleViewTextField.swift"
  "../../../Sources/SDGInterfaceSample/MenuBarSampleWindow.swift"
  "../../../Sources/SDGInterfaceSample/PreferenceManager.swift"
  "../../../Sources/SDGInterfaceSample/SystemMediator.swift"
)
set_target_properties("SDGInterfaceSample" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGInterfaceSample" PRIVATE -enable-testing)
target_link_libraries("SDGInterfaceSample" PRIVATE
  "SDGInterfaceLocalizations"
  "SDGInterfaceBasics"
  "SDGTextDisplay"
  "SDGImageDisplay"
  "SDGButtons"
  "SDGProgressIndicators"
  "SDGWindows"
  "SDGMenus"
  "SDGErrorMessages"
  "SDGMenuBar"
  "SDGApplication"
  "SDGControlFlow"
  "SDGMathematics"
  "SDGText"
  "SDGLocalization"
)

add_library("SDGApplicationTestUtilities"
  "../../../Tests/SDGApplicationTestUtilities/ApplicationTestCase.swift"
  "../../../Tests/SDGApplicationTestUtilities/Window.swift"
)
set_target_properties("SDGApplicationTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGApplicationTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGApplicationTestUtilities" PRIVATE
  "SDGApplication"
  "SDGInterfaceSample"
  "SDGXCTestUtilities"
)

add_library("SDGApplicationTests"
  "../../../Tests/SDGApplicationTests/APITests.swift"
  "../../../Tests/SDGApplicationTests/InterfaceLocalization.swift"
  "../../../Tests/SDGApplicationTests/InternalTests.swift"
)
set_target_properties("SDGApplicationTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGApplicationTests" PRIVATE -enable-testing)
target_link_libraries("SDGApplicationTests" PRIVATE
  "SDGInterfaceBasics"
  "SDGViews"
  "SDGTextDisplay"
  "SDGWindows"
  "SDGMenus"
  "SDGContextMenu"
  "SDGMenuBar"
  "SDGApplication"
  "SDGInterfaceLocalizations"
  "SDGInterfaceSample"
  "SDGApplicationTestUtilities"
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGText"
  "SDGLocalization"
  "SDGXCTestUtilities"
  "SDGLogicTestUtilities"
  "SDGLocalizationTestUtilities"
)

add_library("SDGContextMenuTests"
  "../../../Tests/SDGContextMenuTests/APITests.swift"
)
set_target_properties("SDGContextMenuTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGContextMenuTests" PRIVATE -enable-testing)
target_link_libraries("SDGContextMenuTests" PRIVATE
  "SDGMenus"
  "SDGContextMenu"
  "SDGInterfaceLocalizations"
  "SDGApplicationTestUtilities"
  "SDGControlFlow"
  "SDGLocalization"
  "SDGXCTestUtilities"
)

add_library("SDGInterfaceBasicsTests"
  "../../../Tests/SDGInterfaceBasicsTests/APITests.swift"
)
set_target_properties("SDGInterfaceBasicsTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGInterfaceBasicsTests" PRIVATE -enable-testing)
target_link_libraries("SDGInterfaceBasicsTests" PRIVATE
  "SDGInterfaceBasics"
  "SDGInterfaceLocalizations"
  "SDGApplicationTestUtilities"
  "SDGControlFlow"
  "SDGLogic"
  "SDGLocalization"
  "SDGXCTestUtilities"
)

add_library("SDGKeyboardTests"
  "../../../Tests/SDGKeyboardTests/APITests.swift"
)
set_target_properties("SDGKeyboardTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGKeyboardTests" PRIVATE -enable-testing)
target_link_libraries("SDGKeyboardTests" PRIVATE
  "SDGKeyboard"
  "SDGApplicationTestUtilities"
  "SDGXCTestUtilities"
)

add_library("SDGMenuBarTests"
  "../../../Tests/SDGMenuBarTests/APITests.swift"
)
set_target_properties("SDGMenuBarTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGMenuBarTests" PRIVATE -enable-testing)
target_link_libraries("SDGMenuBarTests" PRIVATE
  "SDGMenus"
  "SDGContextMenu"
  "SDGMenuBar"
  "SDGInterfaceLocalizations"
  "SDGApplicationTestUtilities"
  "SDGControlFlow"
  "SDGLocalization"
  "SDGXCTestUtilities"
)

add_library("SDGMenusTests"
  "../../../Tests/SDGMenusTests/APITests.swift"
)
set_target_properties("SDGMenusTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGMenusTests" PRIVATE -enable-testing)
target_link_libraries("SDGMenusTests" PRIVATE
  "SDGMenus"
  "SDGInterfaceLocalizations"
  "SDGApplicationTestUtilities"
  "SDGControlFlow"
  "SDGText"
  "SDGLocalization"
  "SDGXCTestUtilities"
)

add_library("SDGPopOversTests"
  "../../../Tests/SDGPopOversTests/APITests.swift"
)
set_target_properties("SDGPopOversTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGPopOversTests" PRIVATE -enable-testing)
target_link_libraries("SDGPopOversTests" PRIVATE
  "SDGViews"
  "SDGWindows"
  "SDGPopOvers"
  "SDGApplication"
  "SDGInterfaceSample"
  "SDGApplicationTestUtilities"
  "SDGControlFlow"
  "SDGXCTestUtilities"
)

add_library("SDGTablesTests"
  "../../../Tests/SDGTablesTests/APITests.swift"
)
set_target_properties("SDGTablesTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGTablesTests" PRIVATE -enable-testing)
target_link_libraries("SDGTablesTests" PRIVATE
  "SDGViews"
  "SDGTextDisplay"
  "SDGTables"
  "SDGWindows"
  "SDGApplication"
  "SDGInterfaceSample"
  "SDGApplicationTestUtilities"
  "SDGControlFlow"
  "SDGLocalization"
  "SDGXCTestUtilities"
)

add_library("SDGTextDisplayTests"
  "../../../Tests/SDGTextDisplayTests/APITests.swift"
  "../../../Tests/SDGTextDisplayTests/NSAttributedString.swift"
)
set_target_properties("SDGTextDisplayTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGTextDisplayTests" PRIVATE -enable-testing)
target_link_libraries("SDGTextDisplayTests" PRIVATE
  "SDGInterfaceBasics"
  "SDGViews"
  "SDGWindows"
  "SDGApplication"
  "SDGInterfaceLocalizations"
  "SDGInterfaceSample"
  "SDGApplicationTestUtilities"
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGText"
  "SDGLocalization"
  "SDGXCTestUtilities"
  "SDGLogicTestUtilities"
  "SDGLocalizationTestUtilities"
)

add_library("SDGViewsTestUtilities"
  "../../../Sources/SDGViewsTestUtilities/LegacyView.swift"
  "../../../Sources/SDGViewsTestUtilities/View.swift"
  "../../../Sources/SDGViewsTestUtilities/Windows.swift"
)
set_target_properties("SDGViewsTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGViewsTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGViewsTestUtilities" PRIVATE
  "SDGViews"
  "SDGWindows"
  "SDGInterfaceLocalizations"
  "SDGControlFlow"
  "SDGLogic"
  "SDGTesting"
)

add_library("SDGButtonsTests"
  "../../../Tests/SDGButtonsTests/APITests.swift"
  "../../../Tests/SDGButtonsTests/InternalTests.swift"
  "../../../Tests/SDGButtonsTests/PreviewTests.swift"
)
set_target_properties("SDGButtonsTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGButtonsTests" PRIVATE -enable-testing)
target_link_libraries("SDGButtonsTests" PRIVATE
  "SDGInterfaceBasics"
  "SDGViews"
  "SDGImageDisplay"
  "SDGButtons"
  "SDGApplication"
  "SDGInterfaceSample"
  "SDGInterfaceLocalizations"
  "SDGViewsTestUtilities"
  "SDGApplicationTestUtilities"
  "SDGControlFlow"
  "SDGText"
  "SDGLocalization"
  "SDGXCTestUtilities"
)

add_library("SDGImageDisplayTests"
  "../../../Tests/SDGImageDisplayTests/APITests.swift"
  "../../../Tests/SDGImageDisplayTests/InternalTests.swift"
  "../../../Tests/SDGImageDisplayTests/PreviewTests.swift"
)
set_target_properties("SDGImageDisplayTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGImageDisplayTests" PRIVATE -enable-testing)
target_link_libraries("SDGImageDisplayTests" PRIVATE
  "SDGTextDisplay"
  "SDGApplication"
  "SDGInterfaceSample"
  "SDGViewsTestUtilities"
  "SDGApplicationTestUtilities"
  "SDGXCTestUtilities"
)

add_library("SDGProgressIndicatorsTests"
  "../../../Tests/SDGProgressIndicatorsTests/APITests.swift"
  "../../../Tests/SDGProgressIndicatorsTests/PreviewTests.swift"
)
set_target_properties("SDGProgressIndicatorsTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGProgressIndicatorsTests" PRIVATE -enable-testing)
target_link_libraries("SDGProgressIndicatorsTests" PRIVATE
  "SDGTextDisplay"
  "SDGProgressIndicators"
  "SDGApplication"
  "SDGInterfaceSample"
  "SDGViewsTestUtilities"
  "SDGApplicationTestUtilities"
  "SDGControlFlow"
  "SDGXCTestUtilities"
)

add_library("SDGViewsTests"
  "../../../Tests/SDGViewsTests/APITests.swift"
  "../../../Tests/SDGViewsTests/CocoaExample.swift"
  "../../../Tests/SDGViewsTests/InternalTests.swift"
  "../../../Tests/SDGViewsTests/LegacyMode.swift"
  "../../../Tests/SDGViewsTests/PreviewTests.swift"
  "../../../Tests/SDGViewsTests/SwiftUIExample.swift"
)
set_target_properties("SDGViewsTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGViewsTests" PRIVATE -enable-testing)
target_link_libraries("SDGViewsTests" PRIVATE
  "SDGInterfaceBasics"
  "SDGViews"
  "SDGWindows"
  "SDGApplication"
  "SDGInterfaceSample"
  "SDGViewsTestUtilities"
  "SDGApplicationTestUtilities"
  "SDGControlFlow"
  "SDGXCTestUtilities"
)

add_library("SDGWindowsTests"
  "../../../Tests/SDGWindowsTests/APITests.swift"
)
set_target_properties("SDGWindowsTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGWindowsTests" PRIVATE -enable-testing)
target_link_libraries("SDGWindowsTests" PRIVATE
  "SDGInterfaceBasics"
  "SDGViews"
  "SDGWindows"
  "SDGInterfaceLocalizations"
  "SDGApplicationTestUtilities"
  "SDGControlFlow"
  "SDGText"
  "SDGLocalization"
  "SDGXCTestUtilities"
)

add_executable(WindowsMain
  WindowsMain.swift
)
target_link_libraries(WindowsMain PRIVATE
  "SDGInterfaceResourceGeneration"
  "SDGApplicationTests"
  "SDGContextMenuTests"
  "SDGInterfaceBasicsTests"
  "SDGKeyboardTests"
  "SDGMenuBarTests"
  "SDGMenusTests"
  "SDGPopOversTests"
  "SDGTablesTests"
  "SDGTextDisplayTests"
  "SDGButtonsTests"
  "SDGImageDisplayTests"
  "SDGProgressIndicatorsTests"
  "SDGViewsTests"
  "SDGWindowsTests"
)
add_test(NAME WindowsMain COMMAND WindowsMain)
set_property(TEST WindowsMain PROPERTY ENVIRONMENT "LD_LIBRARY_PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
