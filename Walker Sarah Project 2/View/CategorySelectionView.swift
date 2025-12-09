//
//  CategorySelectionView.swift
//  WalkerSarahProject2
//
//  Created by Sarah Walker on 12/9/25.
//  Copyright © 2025 Apple. All rights reserved.
//

// Claude:
import SwiftUI
import SwiftData

struct CategorySelectionView: View {
    @Binding var selectedIDs: Set<PersistentIdentifier>
    let categories: [Category]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List {
            ForEach(categories) { category in
                CategoryRowView(
                    category: category,
                    isSelected: selectedIDs.contains(category.persistentModelID)
                ) {
                    toggleSelection(for: category)
                }
            }
//            Button("Add Category")
        }
        .navigationTitle("Select Categories")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }

    private func toggleSelection(for category: Category) {
        if selectedIDs.contains(category.persistentModelID) {
            selectedIDs.remove(category.persistentModelID)
        } else {
            selectedIDs.insert(category.persistentModelID)
        }
    }
}
