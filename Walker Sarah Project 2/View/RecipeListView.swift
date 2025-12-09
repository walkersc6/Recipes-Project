/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays a list of recipes.
*/

import SwiftUI
import SwiftData

struct RecipeListView: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    let recipeCategoryName: String?
    
    var body: some View {
        RecipeList(recipeCategoryName: recipeViewModel.selectedCategoryName)
//        if let recipeCategoryName = recipeViewModel.selectedCategoryName {
//            RecipeList(recipeCategoryName: recipeCategoryName)
//        } else {
//            // TODO: switch this to list all recipes
//            ContentUnavailableView("Select a category", systemImage: "sidebar.left")
//            //AllRecipeList(recipes: recipeViewModel.recipes)
//        }
    }
}

private struct RecipeList: View {
    let recipeCategoryName: String?
    @Environment(RecipeViewModel.self) private var recipeViewModel
    @State private var isEditorPresented = false
    @State private var searchText = ""

 
    // Compute filtered results based on search text (code from class and help from Claude:)
    private var searchResults: [Recipe] {
        var filtered = recipeViewModel.recipes
        
        // Switched from class code to code from Claude: https://claude.ai/share/b123bd32-020b-4f26-ae5b-071fcb759ace
        if let categoryName = recipeCategoryName, categoryName != "Recipes" {
            filtered = filtered.filter { recipe in recipe.categories.contains { $0.name == categoryName }
            }
        }
        
        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return filtered
    }

    var body: some View {
        @Bindable var recipeViewModel = recipeViewModel
        List(selection: $recipeViewModel.selectedRecipe) {
            ForEach(searchResults) { recipe in
                NavigationLink(recipe.title, value: recipe)
            }
            .onDelete(perform: removeRecipes)
        }
        .sheet(isPresented: $isEditorPresented) {
            RecipeEditor(recipe: nil, isFavorite: false)
        }
        .overlay {
            if searchResults.isEmpty {
                ContentUnavailableView {
                    Label("No recipes in this category", systemImage: Default.imageName)
                } description: {
                    AddRecipeButton(isActive: $isEditorPresented)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddRecipeButton(isActive: $isEditorPresented)
            }
        }
        .searchable(text: $searchText, prompt: "Search items")
    }
    
    private func removeRecipes(at indexSet: IndexSet) {
        recipeViewModel.removeRecipes(at: indexSet)
    }
}

//// create a list of all recipes
//private struct AllRecipeList: View {
//    let recipes: [Recipe]
//    @Environment(RecipeViewModel.self) private var recipeViewModel
//    @State private var searchText = ""
//
//    
//    private var searchResults: [Recipe] {
//        let all = recipeViewModel.recipes
//        guard !searchText.isEmpty else { return all }
//        return all.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
//    }
//    
//    var body: some View {
//        @Bindable var recipeViewModel = recipeViewModel
//        
//        List(selection: $recipeViewModel.selectedRecipe) {
//            ForEach(searchResults) { recipe in
//                NavigationLink(recipe.title, value: recipe)
//            }
//        }
//    }
//    
//}

private struct AddRecipeButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Add a recipe", systemImage: "plus")
                .help("Add a recipe")
        }
    }
}

//#Preview("RecipeListView") {
//    ModelContainerPreview(ModelContainer.sample) {
//        NavigationStack {
//            RecipeListView(recipeCategoryName: Category.mammal.title)
//                .environment(RecipeViewModel())
//        }
//    }
//}
//
//#Preview("No selected category") {
//    ModelContainerPreview(ModelContainer.sample) {
//        RecipeListView(recipeCategoryName: nil)
//    }
//}
//
//#Preview("No recipes") {
//    ModelContainerPreview(ModelContainer.sample) {
//        RecipeList(recipeCategoryName: Category.fish.title)
//            .environment(RecipeViewModel())
//    }
//}
//
//#Preview("AddRecipeButton") {
//    AddRecipeButton(isActive: .constant(false))
//}
