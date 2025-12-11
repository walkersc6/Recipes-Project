/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A view that displays the details of a recipe.
*/

import SwiftUI
import SwiftData

struct RecipeDetailView: View {
    
    // MARK: - Properties

    @State private var isEditing = false
    @State private var isDeleting = false
    
    @Environment(RecipeViewModel.self) private var recipeViewModel

    var body: some View {
        if let recipe = recipeViewModel.selectedRecipe {
            RecipeDetailContentView(recipe: recipe)
                .navigationTitle("\(recipe.title)")
                .toolbar {
                    // Favorite Button fixed by Claude: https://claude.ai/share/b123bd32-020b-4f26-ae5b-071fcb759ace
                    Button {
                        recipe.isFavorite.toggle()
                    } label: {
                        Label (
                            recipe.isFavorite ? "Unfavorite \(recipe.title)" : "Favorite \(recipe.title)",
                            systemImage: recipe.isFavorite ? "star.fill" : "star"
                        )
                        .help(recipe.isFavorite ? "Unfavorite the recipe" : "Favorite the recipe")
                    }
                    
                    Button { isEditing = true
                        print(URL.applicationSupportDirectory.path())
                    } label: {
                        Label("Edit \(recipe.title)", systemImage: "pencil")
                            .help("Edit the recipe")
                    }
                    
                    Button { isDeleting = true } label: {
                        Label("Delete \(recipe.title)", systemImage: "trash")
                            .help("Delete the recipe")
                    }
                }
                .sheet(isPresented: $isEditing) {
                    RecipeEditor(recipe: recipe, isFavorite: recipe.isFavorite)
                }
                .alert("Delete \(recipe.title)?", isPresented: $isDeleting) {
                    Button("Yes, delete \(recipe.title)", role: .destructive) {
                        delete(recipe)
                    }
                }
        } else {
            ContentUnavailableView("Select a recipe", systemImage: Default.imageName)
        }
    }
    
    private func delete(_ recipe: Recipe) {
        recipeViewModel.selectedRecipe = nil
        recipeViewModel.deleteRecipe(recipe)
    }
}

