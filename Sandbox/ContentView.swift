//
//  ContentView.swift
//  Sandbox
//
//  Created by Raphael Szczepanski on 02.04.24.
//

import SwiftUI
import MacroTesting
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
