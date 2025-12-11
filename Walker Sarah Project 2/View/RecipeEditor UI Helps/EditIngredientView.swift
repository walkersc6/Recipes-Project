//
//  EditIngredientView.swift
//  WalkerSarahProject2
//
//  Created by Sarah Walker on 12/10/25.
//  Copyright © 2025 Apple. All rights reserved.
//

// Claude: https://claude.ai/share/4871cb05-8aae-4ab9-8721-43ffd852c8fd

import SwiftUI

struct EditIngredientView: View {
    @Environment(\.dismiss) private var dismiss
    let ingredient: IngredientItem

    @State private var name: String
    @State private var quantity: String
    @State private var unit: String

    let onSave: (IngredientItem) -> Void

    init(ingredient: IngredientItem, onSave: @escaping (IngredientItem) -> Void) {
        self.ingredient = ingredient
        self.onSave = onSave
        _name = State(initialValue: ingredient.name)
        _quantity = State(initialValue: ingredient.quantity)
        _unit = State(initialValue: ingredient.unit ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Ingredient Name", text: $name)
                    .autocapitalization(.words)

                TextField("Quantity (e.g., 2, 1/2, 1.5)", text: $quantity)

                TextField("Unit (e.g., cups, tbsp, oz)", text: $unit)
                    .autocapitalization(.none)
            }
            .navigationTitle("Edit Ingredient")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        var updated = ingredient
                        updated.name = name
                        updated.quantity = quantity
                        updated.unit = unit.isEmpty ? nil : unit
                        onSave(updated)
                        dismiss()
                    }
                    .disabled(name.isEmpty || quantity.isEmpty)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}
