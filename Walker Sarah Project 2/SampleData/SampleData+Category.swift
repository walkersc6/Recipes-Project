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
        Recipe.cookies.ingredients.append(Ingredient(name: "Semi-Sweet Chocolate Chips", quantity: "2", unit: "Cups", order: 10))
        
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
        Recipe.oatCookies.ingredients.append(Ingredient(name: "Semi-Sweet Chocolate Chips", quantity: "2", unit: "Cups", order: 13))
        
        // ingredients for pork
        Recipe.pork.ingredients.append(Ingredient(name: "Boneless Pork Chop", quantity: "1", unit: "", order: 1))
        Recipe.pork.ingredients.append(Ingredient(name: "Baby Potatoes", quantity: "3", unit: "", order: 2))
        Recipe.pork.ingredients.append(Ingredient(name: "Olive Oil", quantity: "1", unit: "Teaspoon", order: 3))
        Recipe.pork.ingredients.append(Ingredient(name: "Dried Rosemary", quantity: "1/2", unit: "Teaspoon", order: 4))
        Recipe.pork.ingredients.append(Ingredient(name: "Mixed Salt & Pepper", quantity: "1", unit: "Tablespoon", order: 5))

        
        // ingredients for quinoa
        Recipe.quinoa.ingredients.append(Ingredient(name: "Olive Oil", quantity: "2", unit: "Tablespoons", order: 1))
        Recipe.quinoa.ingredients.append(Ingredient(name: "Lemon Juice", quantity: "1", unit: "Tablespoon", order: 2))
        Recipe.quinoa.ingredients.append(Ingredient(name: "Dried Oregano", quantity: "1", unit: "Pinch", order: 3))
        Recipe.quinoa.ingredients.append(Ingredient(name: "Cooked and Cooled Quinoa", quantity: "1/2", unit: "Cup", order: 4))
        Recipe.quinoa.ingredients.append(Ingredient(name: "Canned Chicken", quantity: "1/2", unit: "Cup", order: 5))
        Recipe.quinoa.ingredients.append(Ingredient(name: "Chopped Bell Pepper", quantity: "1/4", unit: "Cup", order: 6))
        Recipe.quinoa.ingredients.append(Ingredient(name: "Chopped Cucumber", quantity: "1/4", unit: "Cup", order: 7))
        Recipe.quinoa.ingredients.append(Ingredient(name: "Spinach", quantity: "1", unit: "Handful", order: 8))

        
        // ingredients for soup
        Recipe.soup.ingredients.append(Ingredient(name: "Chicken & Rice Soup", quantity: "1", unit: "Can", order: 1))
        Recipe.soup.ingredients.append(Ingredient(name: "Water", quantity: "1", unit: "Can", order: 2))
        Recipe.soup.ingredients.append(Ingredient(name: "Chicken", quantity: "1", unit: "Can", order: 3))
        Recipe.soup.ingredients.append(Ingredient(name: "Garlic Powder/Salt", quantity: "1", unit: "Dash", order: 4))
        Recipe.soup.ingredients.append(Ingredient(name: "Ranch Style Beans", quantity: "1", unit: "Can", order: 5))
        Recipe.soup.ingredients.append(Ingredient(name: "Corn", quantity: "1", unit: "Can", order: 6))
        Recipe.soup.ingredients.append(Ingredient(name: "Rotel Tomatoes with Green Chilies", quantity: "1", unit: "Can", order: 7))
        Recipe.soup.ingredients.append(Ingredient(name: "Chopped Onion", quantity: "1", unit: "", order: 8))

        
        // ingredients for muffins
        Recipe.muffin.ingredients.append(Ingredient(name: "Eggs", quantity: "2", unit: "", order: 1))
        Recipe.muffin.ingredients.append(Ingredient(name: "Vanilla", quantity: "3", unit: "Teaspoons", order: 2))
        Recipe.muffin.ingredients.append(Ingredient(name: "Sugar", quantity: "1", unit: "Cup", order: 3))
        Recipe.muffin.ingredients.append(Ingredient(name: "Brown Sugar", quantity: "1", unit: "Cup", order: 4))
        Recipe.muffin.ingredients.append(Ingredient(name: "Vegetable Oil", quantity: "1", unit: "Cup", order: 5))
        Recipe.muffin.ingredients.append(Ingredient(name: "Shredded Zucchini", quantity: "2", unit: "Cups", order: 6))
        Recipe.muffin.ingredients.append(Ingredient(name: "Flour", quantity: "2", unit: "Cup", order: 7))
        Recipe.muffin.ingredients.append(Ingredient(name: "Oats", quantity: "1", unit: "Cup", order: 8))
        Recipe.muffin.ingredients.append(Ingredient(name: "Baking Powder", quantity: "1/2", unit: "Teaspoon", order: 9))
        Recipe.muffin.ingredients.append(Ingredient(name: "Salt", quantity: "1", unit: "Teaspoon", order: 10))
        Recipe.muffin.ingredients.append(Ingredient(name: "Baking Soda", quantity: "1", unit: "Teaspoon", order: 11))
        Recipe.muffin.ingredients.append(Ingredient(name: "Cinnamon", quantity: "1", unit: "Teaspoon", order: 12))
        Recipe.muffin.ingredients.append(Ingredient(name: "Walnuts", quantity: "1/2", unit: "Cup", order: 13))
        Recipe.muffin.ingredients.append(Ingredient(name: "Coconut", quantity: "1", unit: "Cup", order: 14))
        Recipe.muffin.ingredients.append(Ingredient(name: "Milk Chocolate Chips", quantity: "1", unit: "Cup", order: 15))
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
