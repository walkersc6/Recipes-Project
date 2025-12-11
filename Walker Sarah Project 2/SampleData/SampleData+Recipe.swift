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
        makeTime: "10 minutes",
        cookTime: "12 minutes",
        servings: "32 Cookies",
        expertiseRequired: "Easy",
        calories: "78",
        isFavorite: true,
        notes: "I let the vanilla spill over the teaspoon before pouring the rest in"
    )
    static let oatCookies = Recipe(
        title: "Oatmeal Chocolate Chip Cookies",
        author: "Christine Walker",
        makeTime: "20 minutes",
        cookTime: "12 minutes",
        servings: "40 cookies",
        expertiseRequired: "Easy",
        calories: "180",
        notes: "Add a fourth cup flour extra"
    )
    static let pork = Recipe(
        title: "Pork Chops on a Sheet Pan",
        author: "Gemini",
        makeTime: "10 minutes",
        cookTime: "20 minutes",
        servings: "2 servings",
        expertiseRequired: "Easy",
        calories: "280",
        notes: ""
    )
    static let quinoa = Recipe(
        title: "Quinoa Salad",
        author: "Gemini",
        makeTime: "10 minutes",
        cookTime: "30 minutes",
        servings: "3 servings",
        expertiseRequired: "Easy",
        calories: "300",
        notes: "I accidentally did zucchini instead of cucumber, and it was still good."
    )
    static let soup = Recipe(
        title: "Taco Soup",
        author: "Sarah Bohannon",
        makeTime: "10 minutes",
        cookTime: "45 minutes",
        servings: "A lot of Soup",
        expertiseRequired: "Easy",
        calories: "350",
        notes: ""
    )
    static let muffin = Recipe(
        title: "Zucchini Muffins",
        author: "Mallory Elder",
        makeTime: "15 minutes",
        cookTime: "20 minutes",
        servings: "24 muffins",
        expertiseRequired: "Easy",
        calories: "275",
        notes: ""
    )
}
