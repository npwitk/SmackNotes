//
//  NoteCategory.swift
//  SmackNotes
//
//  Created by Nonprawich I. on 07/01/2025.
//

import Foundation
import SwiftData

@Model
class NoteCategory {
    var categoryTitle: String
    
    @Relationship(deleteRule: .cascade, inverse: \Note.category) //Each category contains a set of note, when a category is deleted, all the associated notes will be deleted too!
    var notes: [Note]?
    
    init(categoryTitle: String) {
        self.categoryTitle = categoryTitle
    }
}
