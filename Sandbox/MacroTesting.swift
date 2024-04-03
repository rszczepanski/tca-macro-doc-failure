//
//  MacroTesting.swift
//  Sandbox
//
//  Created by Raphael Szczepanski on 03.04.24.
//

import Foundation
import MacroTesting
import ComposableArchitecture

/// Lorem Ipsum
struct TestStruct {

    @OuterMacro
    enum A {
        case one(B.OuterMacroResult.InnerMacroResult)
    }

    @OuterMacro
    /// Lorem Ipsum
    enum B {
        /// Lorem Ipsum
        case one(A.OuterMacroResult.InnerMacroResult)
    }
}

@Reducer
struct Feature {

    @ObservableState
    struct State {
        /* BREAKS DOCS >>>> */
        var destination: Destination.State
        /* <<<< BREAKS DOCS */
    }

    enum Action {
        /* BREAKS DOCS >>>> */
        case some(Destination.Action)
        /* <<<< BREAKS DOCS */
    }

    @Reducer
    enum Destination {
        case some(AnotherFeature)
    }

    var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}

@Reducer
struct AnotherFeature {

    @ObservableState
    struct State {
    }

    enum Action {
    }

    var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}
