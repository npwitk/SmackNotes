//
//  SmackNotesApp.swift
//  SmackNotes
//
//  Created by Nonprawich I. on 07/01/2025.
//

import SwiftData
import SwiftUI

@main
struct SmackNotesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 400, minHeight: 400)
        }
        .windowResizability(.contentSize)
        .modelContainer(for: [Note.self, NoteCategory.self])
    }
}
