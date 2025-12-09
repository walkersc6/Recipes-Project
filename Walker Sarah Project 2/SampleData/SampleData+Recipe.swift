/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An extension that creates recipe instances for use as sample data.
*/

import Foundation

extension Recipe {
    static let cookies = Recipe(
        title: "Chocolate Chip Cookies",
        author: "Christine Walker",
        servings: "32 Cookies"
    )
    static let cake = Recipe(
        title: "Carrot Cake",
        author: "Gemini",
        servings: "12 Slices"
    )
    static let pretzels = Recipe(
        title: "Bavarian Soft Pretzels",
        author: "Stephen Liddle",
        servings: "A lot of Pretzels"
    )
    static let dinner = Recipe(
        title: "Steak Dinner",
        author: "Ron Wilson",
        servings: "3 Slabs of Steak"
    )
    static let soup = Recipe(
        title: "Taco Soup",
        author: "Sarah Bohannon",
        servings: "A lot of Soup"
    )
    static let muffin = Recipe(
        title: "Zucchini Muffins",
        author: "Mallory Elder",
        servings: ""
    )
}
