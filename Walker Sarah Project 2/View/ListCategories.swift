//
//  ListCategories.swift
//  WalkerSarahProject2
//
//  Created by Sarah Walker on 12/10/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct ListCategories: View {
    var recipeCategories: [Category]
    let isEditing: Bool
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    var body: some View {
        ForEach(recipeCategories) { recipeCategory in
            if isEditing {
                // Claude: https://claude.ai/share/c95253ac-f272-413c-94c2-f9f85cd80bd2
                TextField("Category name", text: Binding (
                    get: { recipeCategory.name },
                    set: { newValue in
                        recipeCategory.name = newValue
                        recipeViewModel.update()
                    }
                ))
            } else {
                NavigationLink(recipeCategory.name, value: recipeCategory.name)
            }
        }
        // Claude: https://claude.ai/share/c95253ac-f272-413c-94c2-f9f85cd80bd2
        .onDelete { indexSet in
            deleteCategories(at: indexSet)
        }
    }

    // Claude: https://claude.ai/share/c95253ac-f272-413c-94c2-f9f85cd80bd2
    private func deleteCategories(at indexSet: IndexSet) {
        for index in indexSet {
            let categoryToDelete = recipeCategories[index]
            recipeViewModel.deleteCategory(categoryToDelete)
        }
    }
}
