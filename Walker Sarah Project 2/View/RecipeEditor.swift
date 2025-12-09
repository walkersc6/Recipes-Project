/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays a data entry form for editing information about a recipe.
*/

import SwiftUI
import SwiftData
import MultiPicker

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
    // Claude: https://claude.ai/share/73501a43-4c5f-4020-b12e-2e41d5bfd720
    @State private var selectedCategoryIDs: Set<PersistentIdentifier> = []
    
    @Environment(\.dismiss) private var dismiss
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    @Query(sort: \Category.name) private var categories: [Category]
    
    
    private var selectedCategories: [Category] {
        categories.filter{ selectedCategoryIDs.contains($0.persistentModelID) }
    }
    
    private var selectedCategoriesText: String {
        if selectedCategoryIDs.isEmpty {
            return "Select categories"
        }
        let sortedNames = selectedCategories.map { $0.name }.sorted()
        return sortedNames.joined(separator: ", ")
    }
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                // Claude: https://claude.ai/share/b123bd32-020b-4f26-ae5b-071fcb759ace
                Toggle("Favorite", isOn: $isFavorite)
                
                // Help from Claude: https://claude.ai/share/73501a43-4c5f-4020-b12e-2e41d5bfd720
                Section("Categories") {
                    // Display selected categories
                    HStack {
                        Text("Selected")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(selectedCategoriesText)
                            .foregroundStyle(selectedCategoryIDs.isEmpty ? .secondary : .primary)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    // Navigate to custom picker
                    NavigationLink {
                        CategorySelectionView(selectedIDs: $selectedCategoryIDs)
                    } label: {
                        Text("Choose Categories")
                    }
                }
                
                Section("Author"){
                    Picker("Author", selection: $selectedAuthor) {
                        ForEach(Recipe.Author.allCases, id: \.self) { author in
                            Text(author.rawValue).tag(author)
                        }
                    }
                }
                
                Section("Details") {
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
                        .disabled(selectedCategories.isEmpty || title.isEmpty)
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", role: .cancel) {
                            dismiss()
                        }
                    }
                }
                .onAppear {
                    guard selectedCategoryIDs.isEmpty else {
                        return
                    }
                    if let recipe {
                        // Edit the incoming recipe.
                        title = recipe.title
                        selectedAuthor = Recipe.Author(rawValue: recipe.author) ?? .cookieSite
                        isFavorite = recipe.isFavorite
                        timeRequired = recipe.timeRequired ?? ""
                        servings = recipe.servings
                        expertiseRequired = recipe.expertiseRequired ?? ""
                        calories = recipe.calories ?? ""
                        notes = recipe.notes ?? ""
                        
                        selectedCategoryIDs = Set(recipe.categories.map { $0.persistentModelID })
                        
                        print("🔵 RecipeEditor onAppear - Loaded \(selectedCategoryIDs.count) category IDs")
                        print("🔵 Category names: \(recipe.categories.map { $0.name })")
                    }
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
            recipe.isFavorite = isFavorite
            recipe.timeRequired = timeRequired.isEmpty ? nil : timeRequired
            recipe.servings = servings
            recipe.expertiseRequired = expertiseRequired.isEmpty ? nil : expertiseRequired
            recipe.calories = calories.isEmpty ? nil : calories
            recipe.notes = notes.isEmpty ? nil : notes
            
            recipe.categories = selectedCategories
            
            recipeViewModel.update()
        } else {
            // Add a recipe.
            let newRecipe = Recipe(
                title: title,
                author: selectedAuthor.rawValue,
                timeRequired: timeRequired.isEmpty ? nil : timeRequired,
                servings: servings,
                expertiseRequired: expertiseRequired.isEmpty ? nil : expertiseRequired,
                calories: calories.isEmpty ? nil : calories,
                isFavorite: isFavorite, // First created from this Claude: https://claude.ai/share/b123bd32-020b-4f26-ae5b-071fcb759ace but reformatted with this Claude conversation: https://claude.ai/share/73501a43-4c5f-4020-b12e-2e41d5bfd720
                notes: notes.isEmpty ? nil : notes
            )
            
            newRecipe.categories = selectedCategories
            
            recipeViewModel.insert(newRecipe)
        }
    }
}

// Claude: https://claude.ai/share/73501a43-4c5f-4020-b12e-2e41d5bfd720
private struct CategoryCell: View {
    let category: Category
    
    var body: some View {
        Text(category.name)
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
