//
//  CategoryRowView.swift
//  WalkerSarahProject2
//
//  Created by Sarah Walker on 12/9/25.
//  Copyright © 2025 Apple. All rights reserved.
//

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

