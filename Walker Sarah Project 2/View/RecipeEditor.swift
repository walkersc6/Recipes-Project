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
    
    @State private var name = ""
    @State private var selectedDiet = Recipe.Diet.herbivorous
    @State private var selectedCategory: Category?
    
    @Environment(\.dismiss) private var dismiss
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    @Query(sort: \Category.name) private var categories: [Category]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Category", selection: $selectedCategory) {
                    Text("Select a category").tag(nil as Category?)
                    ForEach(categories) { category in
                        Text(category.name).tag(category as Category?)
                    }
                }
                
                Picker("Diet", selection: $selectedDiet) {
                    ForEach(Recipe.Diet.allCases, id: \.self) { diet in
                        Text(diet.rawValue).tag(diet)
                    }
                }
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
                    name = recipe.name
                    selectedDiet = recipe.diet
                    selectedCategory = recipe.categories.first // always return optional
                }
            }
        }
    }
    
    private func save() {
        if let recipe {
            // Edit the recipe.
            recipe.name = name
            recipe.diet = selectedDiet
            if let category = selectedCategory {
                recipe.categories = [category]
            } else {
                recipe.categories = []
            }
            recipeViewModel.update()
        } else {
            // Add a recipe.
            let newRecipe = Recipe(name: name, diet: selectedDiet)
            if let category = selectedCategory {
                newRecipe.categories = [category]
            } else {
                newRecipe.categories = []
            }
            recipeViewModel.insert(newRecipe)
        }
    }
}

#Preview("Add recipe") {
    ModelContainerPreview(ModelContainer.sample) {
        RecipeEditor(recipe: nil)
    }
}

#Preview("Edit recipe") {
    ModelContainerPreview(ModelContainer.sample) {
        RecipeEditor(recipe: .pretzels)
    }
}
