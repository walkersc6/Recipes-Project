//
//  IngredientRow.swift
//  WalkerSarahProject2
//
//  Created by Sarah Walker on 12/10/25.
//  Copyright © 2025 Apple. All rights reserved.
//

// Claude: https://claude.ai/share/4871cb05-8aae-4ab9-8721-43ffd852c8fd

import SwiftUI

// Separate view for ingredient row to avoid compiler complexity
struct IngredientRow: View {
    let item: IngredientItem
    let index: Int
    let totalCount: Int
    let onMoveUp: () -> Void
    let onMoveDown: () -> Void
    let onEdit: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            // Up/Down arrows
            VStack(spacing: 4) {
                Button(action: onMoveUp) {
                    Image(systemName: "chevron.up.circle.fill")
                        .foregroundStyle(index == 0 ? .gray : .blue)
                }
                .disabled(index == 0)

                Button(action: onMoveDown) {
                    Image(systemName: "chevron.down.circle.fill")
                        .foregroundStyle(index == totalCount - 1 ? .gray : .blue)
                }
                .disabled(index == totalCount - 1)
            }
            .buttonStyle(.plain)

            // Ingredient info (tappable to edit)
            Button(action: onEdit) {
                HStack(spacing: 8) {
                    Text(item.quantity)
                        .frame(width: 50, alignment: .leading)
                        .foregroundStyle(.secondary)

                    if let unit = item.unit, !unit.isEmpty {
                        Text(unit)
                            .frame(width: 60, alignment: .leading)
                            .foregroundStyle(.secondary)
                    }

                    Text(item.name)
                        .foregroundStyle(.primary)

                    Spacer()

                    Image(systemName: "pencil.circle.fill")
                        .foregroundStyle(.blue)
                        .imageScale(.medium)
                }
            }
        }
        .font(.subheadline)
    }
}
