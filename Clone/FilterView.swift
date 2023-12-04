//
//  FilterView.swift
//  Clone
//
//  Created by Lars Severson on 12/3/23.
//

import SwiftUI

struct FilterView: View {
    @Binding var distance: Double // Binding to the distance value

    var body: some View {
        VStack {
            Text("Distance Preference: \(Int(distance)) miles")
                .font(.headline)
            Slider(value: $distance, in: 1...100, step: 1)
                .padding()

        }
        .padding()
    }
}
