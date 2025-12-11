//
//  CategoryPill.swift
//  WalkerSarahProject2
//
//  Created by Sarah Walker on 12/10/25.
//  Copyright © 2025 Apple. All rights reserved.
//

// Claude: https://claude.ai/share/cb51f93f-335d-4e2e-b986-62fb9e4b2145

import SwiftUI

struct CategoryPill: View {
    let category: Category
    
    var body: some View {
        Text(category.name)
            .font(.subheadline)
            .fontWeight(.medium)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color(.systemGray6))
            )
            .overlay(
                Capsule()
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
    }
}
