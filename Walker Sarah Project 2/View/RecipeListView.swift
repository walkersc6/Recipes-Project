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
        if let recipeCategoryName = recipeViewModel.selectedCategoryName {
            RecipeList(recipeCategoryName: recipeCategoryName)
        } else {
            ContentUnavailableView("Select a category", systemImage: "sidebar.left")
        }
    }
}

private struct RecipeList: View {
    let recipeCategoryName: String
    @Environment(RecipeViewModel.self) private var recipeViewModel
    @State private var isEditorPresented = false
    @State private var searchText = ""

    // Compute filtered results based on search text
    private var searchResults: [Recipe] {
        let all = recipeViewModel.recipes
        guard !searchText.isEmpty else { return all }
        return all.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        @Bindable var recipeViewModel = recipeViewModel
        List(selection: $recipeViewModel.selectedRecipe) {
            ForEach(searchResults) { recipe in
                NavigationLink(recipe.name, value: recipe)
            }
            .onDelete(perform: removeRecipes)
        }
        .sheet(isPresented: $isEditorPresented) {
            RecipeEditor(recipe: nil)
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
//            RecipeListView(recipeCategoryName: Category.mammal.name)
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
//        RecipeList(recipeCategoryName: Category.fish.name)
//            .environment(RecipeViewModel())
//    }
//}
//
//#Preview("AddRecipeButton") {
//    AddRecipeButton(isActive: .constant(false))
//}
