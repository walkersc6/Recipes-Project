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
    static let breakfast = Category(name: "Breakfast")
    static let lunch = Category(name: "Lunch")
    static let dinner = Category(name: "Dinner")
    static let bakedGood = Category(name: "Baked Goods")

    static func insertSampleData(modelContext: ModelContext) {
        
        // Add the recipe categories to the model context.
        modelContext.insert(desserts)
        modelContext.insert(mainDishes)
//        modelContext.insert(austrian)
        modelContext.insert(breakfast)
        modelContext.insert(lunch)
        modelContext.insert(dinner)
        modelContext.insert(bakedGood)
        
        // Add the recipes to the model context.
        modelContext.insert(Recipe.cookies)
        modelContext.insert(Recipe.oatCookies)
        modelContext.insert(Recipe.pork)
        modelContext.insert(Recipe.quinoa)
        modelContext.insert(Recipe.soup)
        modelContext.insert(Recipe.muffin)
        
        // Set the category for each recipe.
        Recipe.cookies.categories.append(desserts)
        Recipe.cookies.categories.append(bakedGood)
        Recipe.oatCookies.categories.append(desserts)
        Recipe.pork.categories.append(dinner)
        Recipe.pork.categories.append(mainDishes)
        Recipe.quinoa.categories.append(lunch)
        Recipe.quinoa.categories.append(mainDishes)
        Recipe.soup.categories.append(dinner)
        Recipe.soup.categories.append(mainDishes)
        Recipe.muffin.categories.append(breakfast)
        Recipe.muffin.categories.append(bakedGood)
        
        // ingredients for cookies
        Recipe.cookies.ingredients.append(Ingredient(name: "Shortening", quantity: "1", unit: "Cup", order: 1))
        Recipe.cookies.ingredients.append(Ingredient(name: "Butter", quantity: "1/3", unit: "Cup", order: 2))
        Recipe.cookies.ingredients.append(Ingredient(name: "Eggs", quantity: "2", unit: "", order: 3))
        Recipe.cookies.ingredients.append(Ingredient(name: "Brown Sugar", quantity: "1", unit: "Cup", order: 4))
        Recipe.cookies.ingredients.append(Ingredient(name: "Sugar", quantity: "1", unit: "Cup", order: 5))
        Recipe.cookies.ingredients.append(Ingredient(name: "Vanilla", quantity: "2", unit: "Teaspoons", order: 6))
        Recipe.cookies.ingredients.append(Ingredient(name: "Flour", quantity: "3", unit: "Cups", order: 7))
        Recipe.cookies.ingredients.append(Ingredient(name: "Baking Soda", quantity: "1", unit: "Teaspoon", order: 8))
        Recipe.cookies.ingredients.append(Ingredient(name: "Salt", quantity: "1", unit: "Teaspoon", order: 9))
        Recipe.cookies.ingredients.append(Ingredient(name: "Chocolate Chips", quantity: "2", unit: "Cups", order: 10))
        
        // ingredients for oatCookies
        Recipe.oatCookies.ingredients.append(Ingredient(name: "Shortening", quantity: "1", unit: "Cup", order: 1))
        Recipe.oatCookies.ingredients.append(Ingredient(name: "Brown Sugar", quantity: "1", unit: "Cup", order: 2))
        Recipe.oatCookies.ingredients.append(Ingredient(name: "Sugar", quantity: "1/2", unit: "Cup", order: 3))
        Recipe.oatCookies.ingredients.append(Ingredient(name: "Egg", quantity: "1", unit: "", order: 4))
        Recipe.oatCookies.ingredients.append(Ingredient(name: "Water", quantity: "1/4", unit: "Cup", order: 5))
        Recipe.oatCookies.ingredients.append(Ingredient(name: "Vanilla", quantity: "1", unit: "Teaspoon", order: 6))
        Recipe.oatCookies.ingredients.append(Ingredient(name: "Flour", quantity: "1", unit: "Cup", order: 7))
        Recipe.oatCookies.ingredients.append(Ingredient(name: "Salt", quantity: "1", unit: "Teaspoon", order: 8))
        Recipe.oatCookies.ingredients.append(Ingredient(name: "Cinnamon", quantity: "1", unit: "Teaspoon", order: 9))
        Recipe.oatCookies.ingredients.append(Ingredient(name: "Baking Soda", quantity: "1/2", unit: "Teaspoon", order: 10))
        Recipe.oatCookies.ingredients.append(Ingredient(name: "Ground Cloves", quantity: "1/2", unit: "Teaspoon", order: 11))
        Recipe.oatCookies.ingredients.append(Ingredient(name: "Oatmeal", quantity: "3", unit: "Cups", order: 12))
        Recipe.oatCookies.ingredients.append(Ingredient(name: "Chocolate Chips", quantity: "2", unit: "Cups", order: 13))
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
