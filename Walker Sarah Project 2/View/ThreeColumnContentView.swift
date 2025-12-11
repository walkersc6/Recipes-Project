/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that shows a list of recipe categories, a list of recipes based on the
 selected category, and the details of the selected recipe.
*/

import SwiftUI
import SwiftData

struct ThreeColumnContentView: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    var body: some View {
        @Bindable var recipeViewModel = recipeViewModel
        NavigationSplitView(columnVisibility: $recipeViewModel.columnVisibility) {
            RecipeCategoryListView()
                .navigationTitle(recipeViewModel.sidebarTitle)
        } content: {
            RecipeListView(recipeCategoryName: recipeViewModel.selectedCategoryName)
                .navigationTitle(recipeViewModel.contentListTitle)
        } detail: {
            NavigationStack {
                RecipeDetailView()
            }
        }
    }
}
