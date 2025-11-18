/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays a list of recipe categories.
*/

import SwiftUI
import SwiftData

struct RecipeCategoryListView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Category.name) private var recipeCategories: [Category]
    @State private var isReloadPresented = false

    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedCategoryName) {
            ListCategories(recipeCategories: recipeCategories)
        }
        .alert("Reload Sample Data?", isPresented: $isReloadPresented) {
            Button("Yes, reload sample data", role: .destructive) {
                reloadSampleData()
            }
        } message: {
            Text("Reloading the sample data deletes all changes to the current data.")
        }
        .toolbar {
            Button {
                isReloadPresented = true
            } label: {
                Label("", systemImage: "arrow.clockwise")
                    .help("Reload sample data")
            }
        }
        .task {
            if recipeCategories.isEmpty {
                Category.insertSampleData(modelContext: modelContext)
            }
        }
    }
    
    @MainActor
    private func reloadSampleData() {
        navigationContext.selectedRecipe = nil
        navigationContext.selectedCategoryName = nil
        Category.reloadSampleData(modelContext: modelContext)
    }
}

private struct ListCategories: View {
    var recipeCategories: [Category]
    
    var body: some View {
        ForEach(recipeCategories) { recipeCategory in
            NavigationLink(recipeCategory.name, value: recipeCategory.name)
        }
    }
}

//#Preview("RecipeCategoryListView") {
//    ModelContainerPreview(ModelContainer.sample) {
//        NavigationStack {
//            RecipeCategoryListView()
//        }
//        .environment(NavigationContext())
//    }
//}
//
//#Preview("ListCategories") {
//    ModelContainerPreview(ModelContainer.sample) {
//        NavigationStack {
//            List {
//                ListCategories(recipeCategories: [.amphibian, .bird])
//            }
//        }
//        .environment(NavigationContext())
//    }
//}
