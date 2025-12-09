/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays a data entry form for editing information about a recipe.
*/

import SwiftUI
import SwiftData

struct RecipeEditor: View {
    let recipe: Recipe?
    
    private var editorTitle: String {
        recipe == nil ? "Add Recipe" : "Edit Recipe"
    }
    
    @State private var title = ""
    @State private var selectedAuthor = Recipe.Author.cookieSite
    @State private var timeRequired = ""
    @State private var servings = ""
    @State private var expertiseRequired = ""
    @State private var calories = ""
    @State var isFavorite: Bool
    @State private var notes = ""
    @State private var selectedCategory: Category?
    
    
    @Environment(\.dismiss) private var dismiss
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    @Query(sort: \Category.name) private var categories: [Category]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                
                Picker("Category", selection: $selectedCategory) {
                    Text("Select a category").tag(nil as Category?)
                    ForEach(categories) { category in
                        Text(category.name).tag(category as Category?)
                    }
                }
                
                Picker("Author", selection: $selectedAuthor) {
                    ForEach(Recipe.Author.allCases, id: \.self) { author in
                        Text(author.rawValue).tag(author)
                    }
                }
                
                TextField("Time Required", text: $timeRequired)
                TextField("Servings", text: $servings)
                TextField("Expertise Required", text: $expertiseRequired)
                TextField("Calories", text: $calories)
//                TextField("Favorite", text: $isFavorite)
                TextField("Notes", text: $notes)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    // Require a category to save changes.
                    .disabled($selectedCategory.wrappedValue == nil)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let recipe {
                    // Edit the incoming recipe.
                    title = recipe.title
                    selectedAuthor = Recipe.Author(rawValue: recipe.author) ?? .cookieSite 
                    selectedCategory = recipe.categories.first // always return optional
                }
            }
        }
    }
    
    private func save() {
        if let recipe {
            // Edit the recipe.
            recipe.title = title
            // Convert enum back to String raw value for the model.
            recipe.author = selectedAuthor.rawValue
            if let category = selectedCategory {
                recipe.categories = [category]
            } else {
                recipe.categories = []
            }
            recipeViewModel.update()
        } else {
            // Add a recipe.
            let newRecipe = Recipe(title: title, author: selectedAuthor.rawValue, servings: servings)
            if let category = selectedCategory {
                newRecipe.categories = [category]
            } else {
                newRecipe.categories = []
            }
            recipeViewModel.insert(newRecipe)
        }
    }
}

//#Preview("Add recipe") {
//    ModelContainerPreview(ModelContainer.sample) {
//        RecipeEditor(recipe: nil)
//    }
//}
//
//#Preview("Edit recipe") {
//    ModelContainerPreview(ModelContainer.sample) {
//        RecipeEditor(recipe: .pretzels)
//    }
//}
