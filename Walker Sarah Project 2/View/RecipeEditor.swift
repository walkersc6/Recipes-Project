/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays a data entry form for editing information about a recipe.
*/

import SwiftUI
import SwiftData
//import MultiPicker

struct RecipeEditor: View {
    let recipe: Recipe?
    
    private var editorTitle: String {
        recipe == nil ? "Add Recipe" : "Edit Recipe"
    }
    
    @State private var title = ""
    @State private var author = ""
    @State private var makeTime = ""
    @State private var cookTime = ""
    @State private var servings = ""
    @State private var expertiseRequired = ""
    @State private var calories = ""
    @State private var instructions = ""
    @State var isFavorite: Bool
    @State private var notes = ""
    // Claude: https://claude.ai/share/73501a43-4c5f-4020-b12e-2e41d5bfd720
    @State private var selectedCategoryIDs: Set<PersistentIdentifier> = []
    // Claude: https://claude.ai/share/4871cb05-8aae-4ab9-8721-43ffd852c8fd
    @State private var ingredients: [IngredientItem] = []
    @State private var showingAddIngredient = false
    @State private var editingIngredient: IngredientItem?
    
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
                
                Section("Details") {
                    TextField("Author", text: $author)
                    TextField("Prep Time", text: $makeTime)
                    TextField("Cook Time", text: $cookTime)
                    TextField("Servings", text: $servings)
                    TextField("Expertise Required", text: $expertiseRequired)
                    TextField("Calories", text: $calories)
                    //                TextField("Favorite", text: $isFavorite)
                }
                
                // Claude: https://claude.ai/share/4871cb05-8aae-4ab9-8721-43ffd852c8fd
                Section("Ingredients") {
                    if ingredients.isEmpty {
                        Text("No ingredients added yet")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                    } else {
                        ForEach(Array(ingredients.enumerated()), id: \.element.id) { index, item in
                            IngredientRow(
                                item: item,
                                index: index,
                                totalCount: ingredients.count,
                                onMoveUp: { moveIngredientUp(at: index) },
                                onMoveDown: { moveIngredientDown(at: index) },
                                onEdit: { editingIngredient = item }
                            )
                        }
                        .onDelete(perform: deleteIngredients)
                    }

                    Button {
                        showingAddIngredient = true
                    } label: {
                        Label("Add Ingredient", systemImage: "plus.circle.fill")
                    }
                }
                
                // Claude: https://claude.ai/share/642cefd7-8d65-4aa7-a5b7-501bd0dcb951
                Section("Instructions") {
                    TextField("Instructions:", text: $instructions, axis: .vertical)
                        .lineLimit(5...10)
                }
                
                Section("Notes") {
                    TextField("Notes", text: $notes, axis: .vertical)
                        .lineLimit(5...10)
                }
            }
            .navigationTitle(editorTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
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
        
            // Claude: https://claude.ai/share/4871cb05-8aae-4ab9-8721-43ffd852c8fd
            .sheet(isPresented: $showingAddIngredient) {
                AddIngredientView { ingredient in
                    ingredients.append(ingredient)
                }
            }
            
            // Claude: https://claude.ai/share/4871cb05-8aae-4ab9-8721-43ffd852c8fd
            .sheet(item: $editingIngredient) { ingredient in
                EditIngredientView(ingredient: ingredient) { updated in
                    if let index = ingredients.firstIndex(where: { $0.id == ingredient.id }) {
                        ingredients[index] = updated
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
                    author = recipe.author
                    isFavorite = recipe.isFavorite
                    makeTime = recipe.makeTime
                    cookTime = recipe.cookTime ?? ""
                    servings = recipe.servings
                    expertiseRequired = recipe.expertiseRequired ?? ""
                    calories = recipe.calories ?? ""
                    instructions = recipe.instructions
                    notes = recipe.notes ?? ""
                    
                    selectedCategoryIDs = Set(recipe.categories.map { $0.persistentModelID })
                    
                    // Claude: https://claude.ai/share/4871cb05-8aae-4ab9-8721-43ffd852c8fd
                    ingredients = recipe.sortedIngredients.map {
                        IngredientItem(name: $0.name, quantity: $0.quantity, unit: $0.unit)
                    }
                    
                }
            }
        }
        
    }
    
    // Claude: https://claude.ai/share/4871cb05-8aae-4ab9-8721-43ffd852c8fd
    private func deleteIngredients(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
    
    // Claude: https://claude.ai/share/4871cb05-8aae-4ab9-8721-43ffd852c8fd
        private func moveIngredientUp(at index: Int) {
            guard index > 0 else { return }
            ingredients.swapAt(index, index - 1)
        }
    
        private func moveIngredientDown(at index: Int) {
            guard index < ingredients.count - 1 else { return }
            ingredients.swapAt(index, index + 1)
        }
    
    private func save() {
        if let recipe {
            // Edit the recipe.
            recipe.title = title
            // Convert enum back to String raw value for the model.
            recipe.author = author
            recipe.isFavorite = isFavorite
            recipe.makeTime = makeTime
            recipe.cookTime = cookTime.isEmpty ? nil : cookTime
            recipe.servings = servings
            recipe.expertiseRequired = expertiseRequired.isEmpty ? nil : expertiseRequired
            recipe.calories = calories.isEmpty ? nil : calories
            recipe.instructions = instructions
            recipe.notes = notes.isEmpty ? nil : notes
            
            recipe.categories = selectedCategories
            
            // Claude: https://claude.ai/share/4871cb05-8aae-4ab9-8721-43ffd852c8fd
            recipe.ingredients.forEach { recipeViewModel.deleteIngredient($0) }
            recipe.ingredients.removeAll()
            
            for (index, item) in ingredients.enumerated() {
                let ingredient = Ingredient(
                    name: item.name,
                    quantity: item.quantity,
                    unit: item.unit ?? "",
                    order: index
                )
                recipeViewModel.insertIngredient(ingredient)
                recipe.ingredients.append(ingredient)
            }
            
            recipeViewModel.update()
        } else {
            // Add a recipe.
            let newRecipe = Recipe(
                title: title,
                author: author,
                makeTime: makeTime,
                cookTime: cookTime.isEmpty ? nil : cookTime,
                servings: servings,
                expertiseRequired: expertiseRequired.isEmpty ? nil : expertiseRequired,
                calories: calories.isEmpty ? nil : calories,
                instructions: instructions,
                isFavorite: isFavorite, // First created from this Claude: https://claude.ai/share/b123bd32-020b-4f26-ae5b-071fcb759ace but reformatted with this Claude conversation: https://claude.ai/share/73501a43-4c5f-4020-b12e-2e41d5bfd720
                notes: notes.isEmpty ? nil : notes
            )
            
            newRecipe.categories = selectedCategories
            
            // Claude: https://claude.ai/share/68aaf836-0b34-478a-a991-86d1a5f29e15
            for (index, item) in ingredients.enumerated() {
                let ingredient = Ingredient(
                    name: item.name,
                    quantity: item.quantity,
                    unit: item.unit ?? "",
                    order: index
                )
                recipeViewModel.insertIngredient(ingredient)
                newRecipe.ingredients.append(ingredient)
            }
            
            recipeViewModel.insert(newRecipe)
        }
    }
}

// Claude: https://claude.ai/share/68aaf836-0b34-478a-a991-86d1a5f29e15
struct IngredientItem: Identifiable {
    let id = UUID()
    var name: String
    var quantity: String
    var unit: String?
    
    static func == (lhs: IngredientItem, rhs: IngredientItem) -> Bool {
            lhs.id == rhs.id
        }
}


// Claude: https://claude.ai/share/73501a43-4c5f-4020-b12e-2e41d5bfd720
private struct CategoryCell: View {
    let category: Category
    
    var body: some View {
        Text(category.name)
    }
}
