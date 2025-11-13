/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that shows a list of animal categories, a list of animals based on the
 selected category, and the details of the selected animal.
*/

import SwiftUI
import SwiftData

struct ThreeColumnContentView: View {
    @Environment(NavigationContext.self) private var navigationContext
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        NavigationSplitView(columnVisibility: $navigationContext.columnVisibility) {
            AnimalCategoryListView()
                .navigationTitle(navigationContext.sidebarTitle)
        } content: {
            AnimalListView(animalCategoryName: navigationContext.selectedCategoryName)
                .navigationTitle(navigationContext.contentListTitle)
        } detail: {
            NavigationStack {
                AnimalDetailView(animal: navigationContext.selectedRecipe)
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
