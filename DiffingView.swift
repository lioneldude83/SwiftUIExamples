//
//  DiffingView.swift
//  Demonstrates SwiftUI's diffing algorithm with computed properties vs. separate View structs.
//
//  Created by Lionel Ng on 26/1/26.
//

import SwiftUI

/// Prefer separate View structs over computed properties for complex views.
/// SwiftUI's diffing algorithm can skip re-evaluating struct bodies when inputs haven't changed,
/// providing performance benefits for Lists, ForEach, and complex layouts.
struct DiffingView: View {
    @State private var count = 0
    
    var body: some View {
        VStack {
            Text("Count is: \(count)")
            
            textView
            
            listView
            
            ListView()
            
            Button("Increase") {
                count += 1
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    /// Demonstrates SwiftUI's diffing algorithm:
    /// Computed properties are re-evaluated every time the parent body is evaluated.
    /// Random border color changes on each state update.
    private var textView: some View {
        Text("Hello, World!")
            .padding(20)
            .border(Color.random())
    }
    
    /// Demonstrates SwiftUI's diffing with computed properties:
    /// When body is re-evaluated, this property is recomputed from scratch.
    /// SwiftUI's diff sees a "new" view hierarchy each time.
    /// Result: Border colors regenerate on every state change.
    private var listView: some View {
        List(Player.samples, id: \.id) { player in
            Text(player.name)
                .padding(12)
                .border(Color.random())
        }
    }
}

/// Demonstrates SwiftUI's diffing with separate View structs:
/// SwiftUI compares view types during diffing. Since ListView has no changing inputs
/// (@State, parameters, etc.), the diffing algorithm determines it's structurally identical.
/// Result: Body is not re-evaluated, border colors remain stable.
private struct ListView: View {
    var body: some View {
        List(Player.samples, id: \.id) { player in
            Text(player.name)
                .padding(12)
                .border(Color.random())
        }
    }
}

struct Player: Identifiable {
    var id: String { self.name }
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    static var samples: [Player] = [
        Player(name: "Albert"),
        Player(name: "Billy"),
        Player(name: "David")
    ]
}

extension Color {
    /// Generates a random color to visualize when SwiftUI re-evaluates view hierarchies.
    static func random() -> Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

#Preview {
    DiffingView()
}
