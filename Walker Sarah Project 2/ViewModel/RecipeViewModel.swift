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
    }
    
    func ensureSomeDataExists()     {
        
        if recipeCategories.isEmpty {
            Category.insertSampleData(modelContext: modelContext)
        }
    }
    
    func reloadSampleData() {
        selectedRecipe = nil
        selectedCategoryName = nil
        Category.reloadSampleData(modelContext: modelContext)
    }
    // ..
    
    // MARK: - Helpers
    
    func update() {
        // TODO
    }
    
    
//    init(selectedRecipeCategoryName: String? = nil,
//         selectedRecipe: Recipe? = nil,
//         columnVisibility: NavigationSplitViewVisibility = .automatic) {
//        self.selectedRecipeCategoryName = selectedRecipeCategoryName
//        self.selectedRecipe = selectedRecipe
//        self.columnVisibility = columnVisibility
//    }
}
