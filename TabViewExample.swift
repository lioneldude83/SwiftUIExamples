//
//  TabViewExample.swift
//  TabView Example with Navigation Path
//
//  Created by Lionel Ng on 18/4/26.
//

import SwiftUI

struct TabViewExample: View {
    @State private var path = NavigationPath()
    @State private var selected = 1
    
    let persons: [Person] = [
        Person(name: "Alice"),
        Person(name: "Bob")
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView(selection: $selected) {
                Tab("Person", systemImage: "person", value: 1) {
                    VStack {
                        ForEach(persons) { person in
                            NavigationLink(person.name, value: Route.person(person.id))
                        }
                    }
                }
                
                Tab("Settings", systemImage: "gear", value: 2) {
                    NavigationLink("Settings", value: Route.settings)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .person(let id):
                    if let person = persons.first(where: { $0.id == id }) {
                        PersonDetailView(person: person)
                    }
                    
                case .settings:
                    SettingsDetailView(path: $path)
                }
            }
        }
    }
}

enum Route: Hashable {
    case person(Person.ID)
    case settings
}

struct Person: Identifiable {
    let id: UUID = UUID()
    let name: String
}

struct PersonDetailView: View {
    let person: Person
    var body: some View {
        VStack {
            Text("Person Detail")
            Text(person.name)
        }
    }
}

struct SettingsDetailView: View {
    @Binding var path: NavigationPath
    var body: some View {
        VStack {
            Text("Settings Detail")
            
            Button("Pop") {
                path.removeLast()
            }
        }
    }
}

#Preview {
    TabViewExample()
}
