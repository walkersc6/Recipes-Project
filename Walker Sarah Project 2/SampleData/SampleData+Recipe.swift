/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An extension that creates recipe instances for use as sample data.
*/

import Foundation

extension Recipe {
    static let cookies = Recipe(name: "Snickerdoodles", diet: .carnivorous)
    static let cake = Recipe(name: "Sachertorte", diet: .carnivorous)
    static let pretzels = Recipe(name: "Bavarian Soft Pretzels", diet: .herbivorous)
    static let gibbon = Recipe(name: "Southern gibbon", diet: .herbivorous)
    static let sparrow = Recipe(name: "House sparrow", diet: .omnivorous)
    static let newt = Recipe(name: "Newt", diet: .carnivorous)
}
