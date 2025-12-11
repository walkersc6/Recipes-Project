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
        instructions: """
            1. **Cream together** the following ingredients:
               - Crisco
               - Butter
               - Sugars
               - Vanilla
               - Eggs

            2. **Add dry ingredients:**
               - Flour
               - Salt
               - Baking soda

            3. **Mix altogether**, then add chocolate chips

            4. **Bake** at 350°F for 10-12 minutes or until done

            > **Tip:** Take out of oven before they look brown - they continue to cook on the pan

            > **Note:** Add a tiny bit of flour to the dough if it is too sticky
            """,
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
        instructions: """
            1. **Preheat oven** to 350°F

            2. **Mix thoroughly** the following wet ingredients until creamy and one color:
               - Shortening
               - Sugars
               - Egg
               - Water
               - Vanilla

            3. **Mix in dry ingredients:**
               - Flour
               - Salt
               - Cinnamon
               - Baking soda
               - Cloves

            4. **Mix in** oatmeal

            5. **Mix in** chocolate chips

            6. **Prepare and bake:**
               - Grease pan or spray with Pam
               - Bake for approximately 10 minutes

            7. **Cooling process:**
               - Remove when cookies look slightly undercooked
               - Let them continue cooking on the pan for a few minutes
               - Transfer to a rack or plate to cool completely

            > **Tip:** These cookies are a little hard and turn out different every time, so be patient and learn as you go!
            """,
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
        instructions: "",
        isFavorite: true,
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
        instructions: "",
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
        instructions: "",
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
        instructions: "",
        notes: ""
    )
}
