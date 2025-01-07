//
//  Note.swift
//  SmackNotes
//
//  Created by Nonprawich I. on 07/01/2025.
//

import SwiftData
import SwiftUI

@Model
class Note {
    var content: String
    var isFavorite: Bool = false
    var category: NoteCategory?
    
    init(content: String, category: NoteCategory? = nil) {
        self.content = content
        self.category = category
    }
}
