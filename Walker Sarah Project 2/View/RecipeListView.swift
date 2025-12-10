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
    }
}

private struct RecipeList: View {
    let recipeCategoryName: String?
    @Environment(RecipeViewModel.self) private var recipeViewModel
    @State private var isEditorPresented = false
    @State private var searchText = ""
    //From Claude: https://claude.ai/share/15777e80-d8ab-45cd-8474-d4a9cfa403e4
    @State private var sortOption: SortOption = .title
    @State private var sortAscending = true
    // Claude:
    @Environment(\.editMode) private var editMode
    
    // Claude: https://claude.ai/share/15777e80-d8ab-45cd-8474-d4a9cfa403e4
    enum SortOption: String, CaseIterable {
        case title = "Title"
        case dateAdded = "Date Added"
    }
    
    // Compute filtered results based on search text (code from class and help from Claude: https://claude.ai/share/b123bd32-020b-4f26-ae5b-071fcb759ace)
    private var searchResults: [Recipe] {
        var filtered = recipeViewModel.recipes
        
        if let categoryName = recipeCategoryName, categoryName != "Recipes", categoryName != "Favorites" {
            filtered = filtered.filter { recipe in recipe.categories.contains { $0.name == categoryName }
            }
        }
        
        if recipeCategoryName == "Favorites" {
            filtered = filtered.filter { recipe in
                recipe.isFavorite == true}
        }
        
        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Claude: https://claude.ai/share/15777e80-d8ab-45cd-8474-d4a9cfa403e4
        switch sortOption {
            // sort functionality is title is selected
        case .title:
            filtered.sort { recipe1, recipe2 in
                let comparison = recipe1.title.localizedCaseInsensitiveCompare(recipe2.title) == .orderedAscending
                return sortAscending ? comparison : !comparison
            }
            // sort functionality if date added is selected
        case .dateAdded:
            filtered.sort { recipe1, recipe2 in
                guard let date1 = recipe1.dateAdded, let date2 = recipe2.dateAdded else {
                    return recipe1.dateAdded != nil
                }
                let comparison = date1 > date2  // Most recent first when ascending
                return sortAscending ? comparison : !comparison
            }
        }
        return filtered
    }
    
    var body: some View {
        @Bindable var recipeViewModel = recipeViewModel
        List(selection: $recipeViewModel.selectedRecipe) {
            ForEach(searchResults) { recipe in
                NavigationLink(recipe.title, value: recipe)
                // Claude: https://claude.ai/share/7914692c-90ad-452d-b1bc-58eb5ff3fd8a
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    if recipeCategoryName != "Recipes" {
                        Button(role: .destructive) {
                            removeRecipe(recipe)
                        } label: {
                            if recipeCategoryName == "Favorites" {
                                Label("Unfavorite", systemImage: "star.slash")
                            } else {
                                Label("Remove", systemImage: "trash")
                            }
                        }
                    }
                }
            }
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
            // From Claude: https://claude.ai/share/15777e80-d8ab-45cd-8474-d4a9cfa403e4
            ToolbarItem(placement: .automatic) {
                Button {
                    sortAscending.toggle()
                } label: {
                    Label(
                        sortAscending ? "Sort Ascending" : "Sort Descending",
                        systemImage: sortAscending ? "arrow.up" : "arrow.down"
                    )
                }
            }
            
            ToolbarItem(placement: .automatic) {
                Menu {
                    Picker("Sort by", selection: $sortOption) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                } label: {
                    Label("Sort", systemImage: "slider.vertical.3")
                }
            }
        }
        .searchable(
            text: $searchText,
            placement: .automatic,
            prompt: "Search items"
        )
    }
    
    // Claude: https://claude.ai/share/7914692c-90ad-452d-b1bc-58eb5ff3fd8a
    private func removeRecipe(_ recipe: Recipe) {
        if recipeCategoryName == "Favorites" {
            recipe.isFavorite = false
        } else if let categoryName = recipeCategoryName {
            if let categoryToRemove = recipe.categories.first(where: { $0.name == categoryName }) {
                recipe.categories.removeAll { $0.persistentModelID == categoryToRemove.persistentModelID }
            }
        }
        recipeViewModel.update()
    }
}
    
//    // Claude: 
//    private func removeRecipes(at indexSet: IndexSet) {
////        withAnimation {
//            let recipesToRemove = indexSet.map { searchResults[$0] }
//            recipeViewModel.removeRecipes(recipesToRemove)
////        }
//        DispatchQueue.main.async {
//            editMode?.wrappedValue = .inactive
//        }
//    }
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
