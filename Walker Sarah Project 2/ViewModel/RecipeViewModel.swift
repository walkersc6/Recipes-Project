/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An observable type that manages attributes of the app's navigation system.
*/

import SwiftUI
import SwiftData

@Observable
class RecipeViewModel: ContextReferencing {
    
    // MARK: - Properties
    private var modelContext: ModelContext
    
    // = "Recipes" came from Claude: https://claude.ai/share/b123bd32-020b-4f26-ae5b-071fcb759ace
    var selectedCategoryName: String? = "Recipes"
    var selectedRecipe: Recipe?
    var columnVisibility: NavigationSplitViewVisibility = .automatic
    
    var sidebarTitle = "Categories"
    
    
    // Claude: https://claude.ai/share/46cc6586-1c27-4c40-9896-8e1c1be076ab
    private var refreshID = UUID()
    

    // MARK: - Initialization
    required init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Model access
    var recipeCategories: [Category] {
        let descriptor = FetchDescriptor<Category>(sortBy: [SortDescriptor(\Category.name)])
        
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    var recipes: [Recipe] {
        let descriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\Recipe.title)])
        //Claude: https://claude.ai/share/bdf88d59-28fd-4807-abbd-5ab154aaac9c
//        if let selectedCategoryName {
//            descriptor.predicate = #Predicate<Recipe> { recipe in
//                recipe.categories.title == selectedCategoryName
//            }
//        }
//        
        return (try? modelContext.fetch(descriptor)) ?? []
    }

    // read (all) recipes
    // read favorites
    // read a category's recipes
    // ..
    
    var contentListTitle: String {
        if let selectedCategoryName {
            selectedCategoryName
        } else {
            ""
        }
    }
    
    func categoryText(for recipe: Recipe) -> String {
        recipe.categories.compactMap(\.name).joined(separator: ", ")
    }
    
    // MARK: - User intents
    
    // create recipe
    // update recipe
    // delete recipe
    
    func delete(_ recipe: Recipe) {
        if selectedRecipe == recipe {
            selectedRecipe = nil
        }
        
        modelContext.delete(recipe)
        update()
    }
    
    func ensureSomeDataExists()     {
        if recipeCategories.isEmpty {
            Category.insertSampleData(modelContext: modelContext)
        }
        update()
    }
    
    func insert(_ recipe: Recipe) {
        modelContext.insert(recipe)
        //save()
        update()
    }
    
    func insertCategory(_ category: Category) {
        modelContext.insert(category)
        try? modelContext.save()
    }
    
    func reloadSampleData() {
        selectedRecipe = nil
        selectedCategoryName = nil
        Category.reloadSampleData(modelContext: modelContext)
        update()
    }
    
    func removeRecipes(at indexSet: IndexSet) {
        for index in indexSet {
            let recipeToDelete = recipes[index]
            if selectedRecipe?.persistentModelID == recipeToDelete.persistentModelID { //how to access auto generated ID
                selectedRecipe = nil
            }
            modelContext.delete(recipeToDelete)
        }
        update()
    }
    
    // Claude:
//    func save() {
//        do {
//            try modelContext.save()
//        } catch {
//            print("Error saving context: \(error)")
//        }
//        update()
//    }
    
    // MARK: - Helpers
    
//    func update() {
//        // TODO: reload the stored properties (recipes, categories, whatever we're storing)
//        // Claude: https://claude.ai/share/46cc6586-1c27-4c40-9896-8e1c1be076ab
//        refreshID = UUID()
//    }
    
    func update() {
        // Save any pending changes
        do {
            try modelContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        // Refresh the view
        refreshID = UUID()
    }
    
    
//    init(selectedRecipeCategoryName: String? = nil,
//         selectedRecipe: Recipe? = nil,
//         columnVisibility: NavigationSplitViewVisibility = .automatic) {
//        self.selectedRecipeCategoryName = selectedRecipeCategoryName
//        self.selectedRecipe = selectedRecipe
//        self.columnVisibility = columnVisibility
//    }
}
