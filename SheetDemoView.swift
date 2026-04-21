//
//  ContentView.swift
//
//  Created by Lionel Ng on 21/4/26.
//

import SwiftUI

struct SheetDemoView: View {
    @State private var showSheet = false
    let colors: [Color] = [.red, .blue, .green, .pink, .orange, .yellow]
    var body: some View {
        VStack {
            Text("This is a sheet demo")
                .font(.largeTitle)
                .padding(.bottom, 48)
            
            List(1...8, id: \.self) { index in
                HStack {
                    Text("Number \(index)")
                    Image(systemName: "star.fill")
                        .foregroundStyle(colors.randomElement()!)
                }
            }
            
            Button("Show Sheet") {
                showSheet = true
            }
            .buttonStyle(.borderedProminent)
        }
        .background(Color(.systemGroupedBackground))
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showSheet) {
            SheetView()
        }
    }
}

struct SheetView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedDetent: PresentationDetent = .medium
    
    private static let shortDetent = PresentationDetent.height(100)
    
    private var title: String {
        selectedDetent == .medium ? "Medium" : "Short"
    }
    
    var body: some View {
        NavigationStack {
            Text("This is the sheet view")
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .presentationDetents(
                    [.medium, Self.shortDetent],
                    selection: $selectedDetent
                )
            // We can add presentation background
            // Note the buttons also change with presentation background
                .presentationBackground(.thickMaterial)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Label("Close", systemImage: "xmark")
                        }
                    }
                }
        }
    }
}

#Preview {
    SheetDemoView()
}
