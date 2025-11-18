/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays a list of recipes.
*/

import SwiftUI
import SwiftData

struct RecipeListView: View {
    let recipeCategoryName: String?
    
    var body: some View {
        if let recipeCategoryName {
            RecipeList(recipeCategoryName: recipeCategoryName)
        } else {
            ContentUnavailableView("Select a category", systemImage: "sidebar.left")
        }
    }
}

private struct RecipeList: View {
    let recipeCategoryName: String
    @Environment(RecipeViewModel.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Recipe.name) private var recipes: [Recipe]
    @State private var isEditorPresented = false

    init(recipeCategoryName: String) {
        self.recipeCategoryName = recipeCategoryName
        let predicate = #Predicate<Recipe> { recipe in
            recipe.category?.name == recipeCategoryName
        }
        _recipes = Query(filter: predicate, sort: \Recipe.name)
    }
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedRecipe) {
            ForEach(recipes) { recipe in
                NavigationLink(recipe.name, value: recipe)
            }
            .onDelete(perform: removeRecipes)
        }
        .sheet(isPresented: $isEditorPresented) {
            RecipeEditor(recipe: nil)
        }
        .overlay {
            if recipes.isEmpty {
                ContentUnavailableView {
                    Label("No recipes in this category", systemImage: "pawprint")
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
    }
    
    private func removeRecipes(at indexSet: IndexSet) {
        for index in indexSet {
            let recipeToDelete = recipes[index]
            if navigationContext.selectedRecipe?.persistentModelID == recipeToDelete.persistentModelID {
                navigationContext.selectedRecipe = nil
            }
            modelContext.delete(recipeToDelete)
        }
    }
}

private struct AddRecipeButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Add an recipe", systemImage: "plus")
                .help("Add an recipe")
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
