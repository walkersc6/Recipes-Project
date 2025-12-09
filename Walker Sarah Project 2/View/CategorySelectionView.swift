//
//  CategorySelectionView.swift
//  WalkerSarahProject2
//
//  Created by Sarah Walker on 12/9/25.
//  Copyright © 2025 Apple. All rights reserved.
//

// Claude: https://claude.ai/share/73501a43-4c5f-4020-b12e-2e41d5bfd720
import SwiftUI
import SwiftData

struct CategorySelectionView: View {
    @Binding var selectedIDs: Set<PersistentIdentifier>
    //let categories: [Category]
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Category.name) private var categories: [Category]

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
        .onAppear {
            print("🟢 CategorySelectionView appeared - selectedIDs count: \(selectedIDs.count)")
        }
        .onDisappear {
            print("🔴 CategorySelectionView disappearing - selectedIDs count: \(selectedIDs.count)")
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
