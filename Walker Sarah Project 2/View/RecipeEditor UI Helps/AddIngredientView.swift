//
//  AddIngredientView.swift
//  WalkerSarahProject2
//
//  Created by Sarah Walker on 12/10/25.
//  Copyright © 2025 Apple. All rights reserved.
//

// Claude: https://claude.ai/share/4871cb05-8aae-4ab9-8721-43ffd852c8fd
import SwiftUI

struct AddIngredientView: View {
        @Environment(\.dismiss) private var dismiss
        @State private var name = ""
        @State private var quantity = ""
        @State private var unit = ""
    
        let onAdd: (IngredientItem) -> Void
    
        var body: some View {
            NavigationStack {
                Form {
                    TextField("Ingredient Name", text: $name)
                        .autocapitalization(.words)
    
                    TextField("Quantity (e.g., 2, 1/2, 1.5)", text: $quantity)
    
                    TextField("Unit (e.g., cups, tbsp, oz)", text: $unit)
                        .autocapitalization(.none)
                }
                .navigationTitle("Add Ingredient")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            let ingredient = IngredientItem(
                                name: name,
                                quantity: quantity,
                                unit: unit.isEmpty ? nil : unit
                            )
                            onAdd(ingredient)
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
