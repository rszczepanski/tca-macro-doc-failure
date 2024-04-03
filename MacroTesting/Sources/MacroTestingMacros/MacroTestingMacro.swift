import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `stringify` macro, which takes an expression
/// of any type and produces a tuple containing the value of that expression
/// and the source code that produced the value. For example
///
///     #stringify(x + y)
///
///  will expand to
///
///     (x + y, "x + y")
public struct StringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let argument = node.argumentList.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }

        return "(\(argument), \(literal: argument.description))"
    }
}

public enum OuterMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        var decls: [DeclSyntax] = []

        decls.append("""
        @InnerMacro
        public enum OuterMacroResult: Equatable {
            case one
        }
        """)

        return decls
    }
}

extension OuterMacro: MemberAttributeMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AttributeSyntax] {
        let attributes: [String] = [
            "InnerMacro"
        ]

        if let enumDecl = member.as(EnumDeclSyntax.self) {
            return attributes.map {
                AttributeSyntax(attributeName: IdentifierTypeSyntax(name: .identifier($0)))
            }
        }

        return []
    }
}

public enum InnerMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        var decls: [DeclSyntax] = []

        decls.append("""
        public enum InnerMacroResult: Equatable {
            case one
        }
        """)

        return decls
    }
}

@main
struct MacroTestingPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
        OuterMacro.self,
        InnerMacro.self
    ]
}
