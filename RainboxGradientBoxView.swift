//
//  RainboxGradientBoxView.swift
//
//  Created by Lionel Ng on 15/11/25.
//

import SwiftUI

struct RainboxGradientBoxView: View {
    @State private var text: String = ""
    @FocusState private var isFocused: Bool
    @State private var isHighlighted: Bool = false
    var body: some View {
        VStack {
            Color.clear
                .frame(maxHeight: .infinity)
                .contentShape(.rect)
                .onTapGesture { isFocused = false }
            TextField("Text", text: $text)
                .focused($isFocused)
                .padding(12)
                // Apply the gradient using the .background modifier
                .background(rainbowGradient())
        }
        .padding()
    }
    
    @ViewBuilder
    private func rainbowGradient() -> some View {
        // Define the rainbow colors array
        let rainbowColors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .indigo]
        let gradientColors: [Color] = Array(repeating: rainbowColors, count: 2)
            .flatMap { $0 }
        
        if !isFocused {
            RoundedRectangle(cornerRadius: 24)
                .stroke(
                    AngularGradient(
                        colors: gradientColors,
                        center: .center,
                        angle: .degrees(isHighlighted ? 360 : 0)
                    ),
                    style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round)
                )
                .padding(-2)
                .blur(radius: 3)
                .onAppear {
                    // Customize the animation/duration as needed
                    withAnimation(.linear(duration: 7.0).repeatForever(autoreverses: false)) {
                        isHighlighted = true
                    }
                }
                .onDisappear {
                    isHighlighted = false
                }
        }
    }
}

#Preview {
    RainboxGradientBoxView()
}
