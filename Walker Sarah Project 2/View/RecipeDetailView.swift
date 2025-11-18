/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays the details of a recipe.
*/

import SwiftUI
import SwiftData

struct RecipeDetailView: View {
    
    // MARK: - Properties

    @State private var isEditing = false
    @State private var isDeleting = false
    
    @Environment(RecipeViewModel.self) private var recipeViewModel

    var body: some View {
        if let recipe = recipeViewModel.selectedRecipe {
            RecipeDetailContentView(recipe: recipe)
                .navigationTitle("\(recipe.name)")
                .toolbar {
                    Button { isEditing = true
                        print(URL.applicationSupportDirectory.path())
                    } label: {
                        Label("Edit \(recipe.name)", systemImage: "pencil")
                            .help("Edit the recipe")
                    }
                    
                    Button { isDeleting = true } label: {
                        Label("Delete \(recipe.name)", systemImage: "trash")
                            .help("Delete the recipe")
                    }
                }
                .sheet(isPresented: $isEditing) {
                    RecipeEditor(recipe: recipe)
                }
                .alert("Delete \(recipe.name)?", isPresented: $isDeleting) {
                    Button("Yes, delete \(recipe.name)", role: .destructive) {
                        delete(recipe)
                    }
                }
        } else {
            ContentUnavailableView("Select a recipe", systemImage: Default.imageName)
        }
    }
    
    private func delete(_ recipe: Recipe) {
        recipeViewModel.selectedRecipe = nil
        modelContext.delete(recipe)
    }
}

private struct RecipeDetailContentView: View {
    let recipe: Recipe

    var body: some View {
        VStack {
            
            //ToDo can we delete this emptyview?
            EmptyView()
            
            List {
                HStack {
                    Text("Category")
                    Spacer()
                    Text("\(recipe.category?.name ?? "")")
                }
                HStack {
                    Text("Diet")
                    Spacer()
                    Text("\(recipe.diet.rawValue)")
                }
            }
        }
    }
}

//#Preview {
//    ModelContainerPreview(ModelContainer.sample) {
//        RecipeDetailView(recipe: .kangaroo)
//            .environment(RecipeViewModel())
//    }
//}
