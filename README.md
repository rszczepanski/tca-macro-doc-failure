# Content

Checks if documentation for inner types is correctly generated.

`MacrtoTesting` contains two macros `OuterMacro` and `InnerMacro` that each generate a `(Outer|Inner)MacroResult` type.

Documentation can be successfully built using the custom macros but not the TCA reducer macros in case of Destination/Path enums.
Documentation building breaks as soon as the inner types are used.

## Macro

- Definition can be found here in [MacroTesting/Sources/MacroTestingMacros/MacroTestingMacro.swift](./MacroTesting/Sources/MacroTesting/MacroTesting.swift)
- Logic can be found here in [MacroTesting/Sources/MacroTestingMacros/MacroTestingMacro.swift](./MacroTesting/Sources/MacroTestingMacros/MacroTestingMacro.swift)

## Usage

- Test code using macros can be found here in [Sandbox/MacroTesting.swift](./Sandbox/MacroTesting.swift)
