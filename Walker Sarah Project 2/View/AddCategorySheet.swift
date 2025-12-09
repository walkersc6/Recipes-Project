//
//  AddCategorySheet.swift
//  WalkerSarahProject2
//
//  Created by Sarah Walker on 12/9/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct AddCategorySheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var categoryName = ""
    let onSave: (Category) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Category Name", text: $categoryName)
                        .autocorrectionDisabled()
                } header: {
                    Text("New Category")
                } footer: {
                    Text("Enter a name for your new category")
                }
            }
            .navigationTitle("Add Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addCategory()                    }
                    .disabled(categoryName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    private func addCategory() {
        let trimmedName = categoryName.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else { return }

    // Create and insert the new category
        let newCategory = Category(name: trimmedName)
        modelContext.insert(newCategory)

        // Save the context
        try? modelContext.save()

        // Call the callback to auto-select it
        onSave(newCategory)

        // Dismiss the sheet
        dismiss()
    }
}
