/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A model class that defines the properties of a recipe
*/

import Foundation
import SwiftData

@Model
final class Recipe {
    var title: String
    var author: String
    var dateAdded: Date?
    var makeTime: String
    var cookTime: String? // no bake cookies don't have a cook time
    var servings: String
    var expertiseRequired: String?
    var calories: String?
    var instructions: String
    var notes: String?
    var isFavorite: Bool
    var categories: [Category]
    @Relationship(deleteRule: .cascade)
    var ingredients: [Ingredient]
    // Claude: https://claude.ai/share/4871cb05-8aae-4ab9-8721-43ffd852c8fd
    var sortedIngredients: [Ingredient] {
        ingredients.sorted(by: { $0.order < $1.order })
    }

    init(title: String, author: String, dateAdded: Date? = nil, makeTime: String, cookTime: String? = nil, servings: String, expertiseRequired: String? = nil, calories: String? = nil, instructions: String, isFavorite: Bool = false, notes: String? = nil) {
        self.title = title
        self.author = author
        self.dateAdded = Date()
        self.makeTime = makeTime
        self.cookTime = cookTime
        self.servings = servings
        self.expertiseRequired = expertiseRequired
        self.calories = calories
        self.isFavorite = isFavorite
        self.instructions = instructions
        self.notes = notes
        categories = []
        ingredients = []
    }
}

// inspired from Dr. Liddle's recipe code
// make searches more helpful
extension Recipe {
    var asSearchString: String {
        let result = "\(title) \(author) \(makeTime) \(cookTime ?? "") \(servings) \(calories ?? "") \(notes ?? "")"
        return result.lowercased()
        
    }
}
