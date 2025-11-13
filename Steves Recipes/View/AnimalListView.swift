/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays a list of animals.
*/

import SwiftUI
import SwiftData

struct AnimalListView: View {
    let animalCategoryName: String?
    
    var body: some View {
        if let animalCategoryName {
            AnimalList(animalCategoryName: animalCategoryName)
        } else {
            ContentUnavailableView("Select a category", systemImage: "sidebar.left")
        }
    }
}

private struct AnimalList: View {
    let animalCategoryName: String
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Recipe.name) private var animals: [Recipe]
    @State private var isEditorPresented = false

    init(animalCategoryName: String) {
        self.animalCategoryName = animalCategoryName
        let predicate = #Predicate<Recipe> { animal in
            animal.category?.name == animalCategoryName
        }
        _animals = Query(filter: predicate, sort: \Recipe.name)
    }
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedRecipe) {
            ForEach(animals) { animal in
                NavigationLink(animal.name, value: animal)
            }
            .onDelete(perform: removeAnimals)
        }
        .sheet(isPresented: $isEditorPresented) {
            AnimalEditor(animal: nil)
        }
        .overlay {
            if animals.isEmpty {
                ContentUnavailableView {
                    Label("No animals in this category", systemImage: "pawprint")
                } description: {
                    AddAnimalButton(isActive: $isEditorPresented)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddAnimalButton(isActive: $isEditorPresented)
            }
        }
    }
    
    private func removeAnimals(at indexSet: IndexSet) {
        for index in indexSet {
            let animalToDelete = animals[index]
            if navigationContext.selectedRecipe?.persistentModelID == animalToDelete.persistentModelID {
                navigationContext.selectedRecipe = nil
            }
            modelContext.delete(animalToDelete)
        }
    }
}

private struct AddAnimalButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Add an animal", systemImage: "plus")
                .help("Add an animal")
        }
    }
}

//#Preview("AnimalListView") {
//    ModelContainerPreview(ModelContainer.sample) {
//        NavigationStack {
//            AnimalListView(animalCategoryName: Category.mammal.name)
//                .environment(NavigationContext())
//        }
//    }
//}
//
//#Preview("No selected category") {
//    ModelContainerPreview(ModelContainer.sample) {
//        AnimalListView(animalCategoryName: nil)
//    }
//}
//
//#Preview("No animals") {
//    ModelContainerPreview(ModelContainer.sample) {
//        AnimalList(animalCategoryName: Category.fish.name)
//            .environment(NavigationContext())
//    }
//}
//
//#Preview("AddAnimalButton") {
//    AddAnimalButton(isActive: .constant(false))
//}
