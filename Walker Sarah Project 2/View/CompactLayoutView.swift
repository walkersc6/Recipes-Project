//
//  CompactLayoutView.swift
//  WalkerSarahProject2
//
//  Created by Sarah Walker on 12/1/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct CompactRecipeView: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    @State private var showCategories = false

    var body: some View {
        @Bindable var recipeViewModel = recipeViewModel
        
        NavigationStack {
            RecipeListView(recipeCategoryName: recipeViewModel.selectedCategoryName)
                .navigationTitle(
                    recipeViewModel.selectedCategoryName ?? "All Recipes"
                )
                .toolbar {
                    Button("Categories") {
                        showCategories = true
                    }
                }
                .sheet(isPresented: $showCategories) {
                    NavigationStack {
                        RecipeCategoryListView()
                            .navigationTitle("Categories")
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Done") {
                                        showCategories = false
                                    }
                                }
                            }
                    }
                }
        }
    }
}
