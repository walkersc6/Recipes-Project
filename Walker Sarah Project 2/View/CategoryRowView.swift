//
//  CategoryRowView.swift
//  WalkerSarahProject2
//
//  Created by Sarah Walker on 12/9/25.
//  Copyright © 2025 Apple. All rights reserved.
//


// Claude: https://claude.ai/share/73501a43-4c5f-4020-b12e-2e41d5bfd720

import SwiftUI

struct CategoryRowView: View {
    let category: Category
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                Text(category.name)
                    .foregroundStyle(.primary)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.blue)
                } else {
                    Image(systemName: "circle")
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

