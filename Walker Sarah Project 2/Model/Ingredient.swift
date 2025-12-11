//
//  Ingredient.swift
//  WalkerSarahProject2
//
//  Created by Sarah Walker on 12/10/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation
import SwiftData

@Model
final class Ingredient {
    var name: String
    var quantity: String
    var unit: String? // like 2 egg
    var order: Int
    
    // Claude: https://claude.ai/share/e23fa34b-5032-43d6-ab53-0ead2e09bab8
    @Relationship(inverse: \Recipe.ingredients)
    var recipe: Recipe?
        
    init(name: String, quantity: String, unit: String, order: Int) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.order = order
    }
}
