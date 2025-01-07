//
//  Home.swift
//  SmackNotes
//
//  Created by Nonprawich I. on 07/01/2025.
//

import SwiftData
import SwiftUI

struct Home: View {
    @State private var selectedTag: String? = "All Notes"
    @Query(animation: .snappy) private var categories: [NoteCategory] // Query all categories
    @Environment(\.modelContext) private var context
    
    @State private var addCategory: Bool = false
    @State private var categoryTitle: String = ""
    
    @State private var requestedCategory: NoteCategory?
    @State private var deletedRequest: Bool = false
    @State private var renameRequest: Bool = false
    
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedTag) {
                Text("All Notes")
                    .tag("All Notes")
                    .foregroundStyle(selectedTag == "All Notes" ? Color.primary : .gray)
                
                Text("Favorites")
                    .tag("Favorites")
                    .foregroundStyle(selectedTag == "Favorites" ? Color.primary : .gray)
                
                Section {
                    ForEach(categories) { category in
                        Text(category.categoryTitle)
                            .tag(category.categoryTitle)
                            .foregroundStyle(selectedTag ==
                                             category.categoryTitle ? Color.primary : .gray)
                            .contextMenu {
                                Button("Rename") {
                                    categoryTitle = category.categoryTitle
                                    requestedCategory = category
                                    renameRequest = true
                                }
                                
                                Button("Delete") {
                                    categoryTitle = category.categoryTitle
                                    requestedCategory = category
                                    deletedRequest = true
                                }
                            }
                        
                    }
                } header: {
                    HStack(spacing: 5) {
                        Text("Categories")
                        
                        Button("", systemImage: "plus") {
                            addCategory.toggle()
                        }
                        .tint(.gray)
                        .buttonStyle(.plain)
                    }
                }
            }
            
        } detail: {
            NotesView(category: selectedTag, allCategories: categories)
        }
        .navigationTitle(selectedTag ?? "Notes")
        .alert("Add Category", isPresented: $addCategory) {
            TextField("Record Video", text: $categoryTitle)
            
            Button("Cancel", role: .cancel) {
                categoryTitle = ""
            }
            
            Button("Add") {
                // Add new category to SwiftData
                let category = NoteCategory(categoryTitle: categoryTitle)
                context.insert(category)
                categoryTitle = ""
            }
        }
        .alert("Rename Category", isPresented: $renameRequest) {
            
            TextField("Record Video", text: $categoryTitle)
            
            Button("Cancel", role: .cancel) {
                categoryTitle = ""
                requestedCategory = nil
            }
            
            Button("Rename") {
                if let requestedCategory {
                    requestedCategory.categoryTitle = categoryTitle
                    categoryTitle = ""
                    self.requestedCategory = nil
                }
            }
            
        }
        
        .alert("Are you sure to delete \(categoryTitle) category?", isPresented: $deletedRequest) {
            
            Button("Cancel", role: .cancel) {
                categoryTitle = ""
                requestedCategory = nil
            }
            
            Button("Delete", role: .destructive) {
                if let requestedCategory {
                    context.delete(requestedCategory)
                    categoryTitle = ""
                    self.requestedCategory = nil
                }
            }
            
        }
        
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("", systemImage: "plus") {
                    let note = Note(content: "")
                    context.insert(note)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
