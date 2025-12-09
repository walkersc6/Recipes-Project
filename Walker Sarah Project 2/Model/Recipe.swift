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
    var timeRequired: String? // or int? idk yet
    var servings: String
    var expertiseRequired: String?
    var calories: String?
    var isFavorite: Bool
    var notes: String?
    var categories: [Category]
    
    init(title: String, author: String, dateAdded: Date? = nil, timeRequired: String? = nil, servings: String, expertiseRequired: String? = nil, calories: String? = nil, isFavorite: Bool = false, notes: String? = nil) {
        self.title = title
        self.author = author
        self.dateAdded = Date()
        self.timeRequired = timeRequired
        self.servings = servings
        self.calories = calories
        self.isFavorite = isFavorite
        self.notes = notes
        categories = []
    }
}

extension Recipe {
    enum Author: String, CaseIterable, Codable {
        case cookieSite = "Cookies with Karli"
        case neighbor = "Sarah Bohannon"
        case gemini = "Gemini"
    }
}

// inspired from Dr. Liddle's recipe code
// make searches more helpful
extension Recipe {
    var asSearchString: String {
        let result = "\(title) \(author) \(timeRequired ?? "") \(servings) \(calories ?? "") \(notes ?? "")"
        return result.lowercased()
        
    }
}
