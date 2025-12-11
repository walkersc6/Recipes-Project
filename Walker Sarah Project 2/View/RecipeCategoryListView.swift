/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays a list of recipe categories.
*/

import SwiftUI
import SwiftData

struct RecipeCategoryListView: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    // Claude: https://claude.ai/share/c95253ac-f272-413c-94c2-f9f85cd80bd2
    @Environment(\.editMode) private var editMode
    @State private var isCreatorPresented = false

    var body: some View {
        @Bindable var recipeViewModel = recipeViewModel

        // list Categories
        List(selection: $recipeViewModel.selectedCategoryName) {
            NavigationLink("All Recipes", value: "Recipes")
            NavigationLink("Favorites", value: "Favorites")

            ListCategories(recipeCategories: recipeViewModel.recipeCategories, isEditing: editMode?.wrappedValue == .active) // isEditing param from Claude: https://claude.ai/share/c95253ac-f272-413c-94c2-f9f85cd80bd2
        }
        // Claude: https://claude.ai/share/5a75dadc-5af6-4a13-a625-bf11133325c1
        .sheet(isPresented: $isCreatorPresented) {
            AddCategorySheet { _ in
                recipeViewModel.update()
            }
        }
        .toolbar {
            // Claude: https://claude.ai/share/5a75dadc-5af6-4a13-a625-bf11133325c1
            ToolbarItem(placement: .automatic) {
                Button {
                    isCreatorPresented = true
                } label: {
                    Label("Add a category", systemImage: "plus")
                        .help("Add a category")
                }
            }
            ToolbarItem(placement: .automatic) {
            // Claude: https://claude.ai/share/c95253ac-f272-413c-94c2-f9f85cd80bd2
                Button {
                    if editMode?.wrappedValue == .active {
                        editMode?.wrappedValue = .inactive
                    } else {
                        editMode?.wrappedValue = .active
                    }
                } label: {
                    Label(
                        editMode?.wrappedValue == .active ? "Done" : "Edit",
                        systemImage: editMode?.wrappedValue == .active ? "checkmark" : "pencil"
                    )
                    .help(editMode?.wrappedValue == .active ? "Done editing" : "Edit categories")
                }
            }
            
        }
        .task {
            recipeViewModel.ensureSomeDataExists()
        }
    }
}
