/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that shows a list of recipe categories, a list of recipes based on the
 selected category, and the details of the selected recipe.
*/

import SwiftUI
import SwiftData

struct ThreeColumnContentView: View {
    @Environment(NavigationContext.self) private var navigationContext
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        NavigationSplitView(columnVisibility: $navigationContext.columnVisibility) {
            RecipeCategoryListView()
                .navigationTitle(navigationContext.sidebarTitle)
        } content: {
            RecipeListView(recipeCategoryName: navigationContext.selectedCategoryName)
                .navigationTitle(navigationContext.contentListTitle)
        } detail: {
            NavigationStack {
                RecipeDetailView(recipe: navigationContext.selectedRecipe)
            }
        }
    }
}

//#Preview {
//    ModelContainerPreview(ModelContainer.sample) {
//        ThreeColumnContentView()
//            .environment(NavigationContext())
//    }
//}
