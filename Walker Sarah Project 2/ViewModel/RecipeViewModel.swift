/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An observable type that manages attributes of the app's navigation system.
*/

import SwiftUI
import SwiftData

@Observable
class RecipeViewModel: ContextReferencing {
    private var modelContext: ModelContext

    var selectedCategoryName: String?
    var selectedRecipe: Recipe?
    var columnVisibility: NavigationSplitViewVisibility = .automatic
    
    var sidebarTitle = "Categories"
    

    required init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func update() {
        // TODO
    }
    
    var contentListTitle: String {
        if let selectedCategoryName {
            selectedCategoryName
        } else {
            ""
        }
    }
    
//    init(selectedRecipeCategoryName: String? = nil,
//         selectedRecipe: Recipe? = nil,
//         columnVisibility: NavigationSplitViewVisibility = .automatic) {
//        self.selectedRecipeCategoryName = selectedRecipeCategoryName
//        self.selectedRecipe = selectedRecipe
//        self.columnVisibility = columnVisibility
//    }
}
