/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A model class that defines the properties of an animal.
*/

import Foundation
import SwiftData

@Model
final class Recipe {
    var name: String
    var diet: Diet
    var category: Category?
    
    init(name: String, diet: Diet) {
        self.name = name
        self.diet = diet
    }
}

extension Recipe {
    enum Diet: String, CaseIterable, Codable {
        case herbivorous = "Herbivore"
        case carnivorous = "Carnivore"
        case omnivorous = "Omnivore"
    }
}
