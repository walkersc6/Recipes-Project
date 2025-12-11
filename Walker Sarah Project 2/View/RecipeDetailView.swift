/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A view that displays the details of a recipe.
*/

import SwiftUI
import SwiftData
import MarkdownUI

struct RecipeDetailView: View {
    
    // MARK: - Properties

    @State private var isEditing = false
    @State private var isDeleting = false
    
    @Environment(RecipeViewModel.self) private var recipeViewModel

    var body: some View {
        if let recipe = recipeViewModel.selectedRecipe {
            RecipeDetailContentView(recipe: recipe)
                .navigationTitle("\(recipe.title)")
                .toolbar {
                    // Favorite Button fixed by Claude: https://claude.ai/share/b123bd32-020b-4f26-ae5b-071fcb759ace
                    Button {
                        recipe.isFavorite.toggle()
                    } label: {
                        Label (
                            recipe.isFavorite ? "Unfavorite \(recipe.title)" : "Favorite \(recipe.title)",
                            systemImage: recipe.isFavorite ? "star.fill" : "star"
                        )
                        .help(recipe.isFavorite ? "Unfavorite the recipe" : "Favorite the recipe")
                    }
                    
                    Button { isEditing = true
                        print(URL.applicationSupportDirectory.path())
                    } label: {
                        Label("Edit \(recipe.title)", systemImage: "pencil")
                            .help("Edit the recipe")
                    }
                    
                    Button { isDeleting = true } label: {
                        Label("Delete \(recipe.title)", systemImage: "trash")
                            .help("Delete the recipe")
                    }
                }
                .sheet(isPresented: $isEditing) {
                    RecipeEditor(recipe: recipe, isFavorite: recipe.isFavorite)
                }
                .alert("Delete \(recipe.title)?", isPresented: $isDeleting) {
                    Button("Yes, delete \(recipe.title)", role: .destructive) {
                        delete(recipe)
                    }
                }
        } else {
            ContentUnavailableView("Select a recipe", systemImage: Default.imageName)
        }
    }
    
    private func delete(_ recipe: Recipe) {
        recipeViewModel.selectedRecipe = nil
        recipeViewModel.deleteRecipe(recipe)
    }
}

private struct RecipeDetailContentView: View {
    let recipe: Recipe
    @Environment(RecipeViewModel.self) private var recipeViewModel
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    private var columns: [GridItem] {
        // Use 3 columns in landscape (regular width), 2 in portrait (compact width)
        let columnCount = horizontalSizeClass == .regular ? 3 : 2
        return Array(repeating: GridItem(.flexible(), spacing: 16), count: columnCount)
    }
    
    var body: some View {
        // Claude: https://claude.ai/share/cb51f93f-335d-4e2e-b986-62fb9e4b2145
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Main Info Grid
                LazyVGrid(columns: columns, spacing: 16) {
                    InfoCard(
                        icon: "person.fill",
                        title: "Author",
                        value: recipe.author,
                        color: .orange
                    )
                    
                    InfoCard(
                        icon: "fork.knife",
                        title: "Servings",
                        value: recipe.servings,
                        color: .green
                    )
                    
                    
                    InfoCard(
                        icon: "timer",
                        title: "Prep Time",
                        value: recipe.makeTime,
                        color: .blue
                    )
                    
                    
                    if let cookTime = recipe.cookTime, !cookTime.isEmpty {
                        InfoCard(
                            icon: "clock.fill",
                            title: "Cook Time",
                            value: cookTime,
                            color: .cyan
                        )
                    }
                    
                    if let expertise = recipe.expertiseRequired, !expertise.isEmpty {
                        InfoCard(
                            icon: "star.fill",
                            title: "Difficulty",
                            value: expertise,
                            color: .purple
                        )
                    }
                    
                    if let calories = recipe.calories, !calories.isEmpty {
                        InfoCard(
                            icon: "flame.fill",
                            title: "Calories",
                            value: calories,
                            color: .red
                        )
                    }
                    
                    if let dateAdded = recipe.dateAdded {
                        InfoCard(
                            icon: "calendar",
                            title: "Date Added",
                            value: dateAdded.formatted(date: .abbreviated, time: .omitted),
                            color: .indigo
                        )
                    }
                }
                .padding(.horizontal, 20)
                
                // Categories Section
                if !recipe.categories.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Categories", systemImage: "tag.fill")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        FlowLayout(spacing: 8) {
                            ForEach(recipe.categories) { category in
                                CategoryPill(category: category)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
//                // Claude: https://claude.ai/share/e23fa34b-5032-43d6-ab53-0ead2e09bab8
                VStack {
                    Text("Ingredients")
                        .font(.title2)
                        .bold()
//                        .padding(.horizontal, 20)
                        .padding(.bottom, 4)
                    
                    if recipe.ingredients.isEmpty {
                        Text("No ingredients added")
                            .foregroundStyle(.secondary)
//                            .padding(.horizontal, 20)
                    } else {
                        ForEach(recipe.sortedIngredients) { ingredient in
                            HStack(spacing: 8) {
                                Text("•")
                                    .font(.body)
                                    .frame(width: 10, alignment: .leading)
                                Text("\(ingredient.quantity) \(ingredient.unit ?? "") \(ingredient.name)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                //                                    .foregroundStyle(.secondary)
                                //                                Text(ingredient.name)
                            }
//                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.horizontal, 20)

                
                // Claude: https://claude.ai/share/642cefd7-8d65-4aa7-a5b7-501bd0dcb951
                // formatted by this Claude convo:
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Instructions")
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 4)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Markdown(recipe.instructions)
//                            .padding(.horizontal, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
//                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))

                }
                
                
                
                // Notes Section
                if let notes = recipe.notes, !notes.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Notes", systemImage: "note.text")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                        
                        Text(notes)
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(.vertical, 20)
        }
    }
}
