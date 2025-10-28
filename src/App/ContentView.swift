//
//  ContentView.swift
//  TidalHabits
//
//  Created on 2025-10-28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("TidalHabits")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("習慣養成，從今天開始")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
