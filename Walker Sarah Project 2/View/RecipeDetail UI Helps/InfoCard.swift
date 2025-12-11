//
//  InfoCard.swift
//  WalkerSarahProject2
//
//  Created by Sarah Walker on 12/10/25.
//  Copyright © 2025 Apple. All rights reserved.
//


// Claude: https://claude.ai/share/cb51f93f-335d-4e2e-b986-62fb9e4b2145

import SwiftUI

struct InfoCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(color)
                
                Spacer()
            }
            
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text(value)
                .font(.headline)
                .lineLimit(2)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }
}
