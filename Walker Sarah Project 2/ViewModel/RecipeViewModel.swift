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

    var selectedCategoryName: String?
    var selectedRecipe: Recipe?
    var columnVisibility: NavigationSplitViewVisibility = .automatic
    
    var sidebarTitle = "Categories"
    

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
        let descriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\Recipe.name)])
        
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
    // ..
    
    // MARK: - Helpers
    
    func update() {
        // TODO: reload the stored properties (recipes, categories, whatever we're storing
    }
    
    
//    init(selectedRecipeCategoryName: String? = nil,
//         selectedRecipe: Recipe? = nil,
//         columnVisibility: NavigationSplitViewVisibility = .automatic) {
//        self.selectedRecipeCategoryName = selectedRecipeCategoryName
//        self.selectedRecipe = selectedRecipe
//        self.columnVisibility = columnVisibility
//    }
}
