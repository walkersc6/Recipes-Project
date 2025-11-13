/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An extension that creates animal category instances for use as sample data.
*/

import Foundation
import SwiftData

extension Category {
    static let desserts = Category(name: "Desserts")
    static let mainDishes = Category(name: "Main Dishes")
    static let austrian = Category(name: "Austrian")
    static let invertebrate = Category(name: "Invertebrate")
    static let mammal = Category(name: "Mammal")
    static let reptile = Category(name: "Reptile")

    static func insertSampleData(modelContext: ModelContext) {
        // Add the animal categories to the model context.
        modelContext.insert(desserts)
        modelContext.insert(mainDishes)
        modelContext.insert(austrian)
        modelContext.insert(invertebrate)
        modelContext.insert(mammal)
        modelContext.insert(reptile)
        
        // Add the animals to the model context.
        modelContext.insert(Recipe.cookies)
        modelContext.insert(Recipe.cake)
        modelContext.insert(Recipe.pretzels)
        modelContext.insert(Recipe.gibbon)
        modelContext.insert(Recipe.sparrow)
        modelContext.insert(Recipe.newt)
        
        // Set the category for each animal.
        Recipe.cookies.category = desserts
        Recipe.cake.category = desserts
        Recipe.pretzels.category = austrian
        Recipe.gibbon.category = mammal
        Recipe.sparrow.category = mainDishes
        Recipe.newt.category = desserts
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
