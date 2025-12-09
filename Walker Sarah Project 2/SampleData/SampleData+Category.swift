/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An extension that creates recipe category instances for use as sample data.
*/

import Foundation
import SwiftData

extension Category {
    static let desserts = Category(name: "Desserts")
    static let mainDishes = Category(name: "Main Dishes")
    static let austrian = Category(name: "Austrian")
    static let dinner = Category(name: "Dinner")
    static let breakfast = Category(name: "Breakfast")
    static let bakedGood = Category(name: "Baked Goods")

    static func insertSampleData(modelContext: ModelContext) {
        
        // Add the recipe categories to the model context.
        modelContext.insert(desserts)
        modelContext.insert(mainDishes)
        modelContext.insert(austrian)
        modelContext.insert(dinner)
        modelContext.insert(breakfast)
        modelContext.insert(bakedGood)
        
        // Add the recipes to the model context.
        modelContext.insert(Recipe.cookies)
        modelContext.insert(Recipe.cake)
        modelContext.insert(Recipe.pretzels)
        modelContext.insert(Recipe.dinner)
        modelContext.insert(Recipe.soup)
        modelContext.insert(Recipe.muffin)
        
        // Set the category for each recipe.
        Recipe.cookies.categories.append(desserts)
        Recipe.cookies.categories.append(bakedGood)
        Recipe.cake.categories.append(desserts)
        Recipe.pretzels.categories.append(austrian)
        Recipe.pretzels.categories.append(mainDishes)
        Recipe.dinner.categories.append(dinner)
        Recipe.soup.categories.append(dinner)
        Recipe.soup.categories.append(mainDishes)
        Recipe.muffin.categories.append(desserts)
        Recipe.muffin.categories.append(bakedGood)
    }
    
    static func reloadSampleData(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Category.self)
            insertSampleData(modelContext: modelContext)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
