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
        instructions: """
            ## Instructions

            1. Preheat your oven or toaster oven to 400°F (200°C)

            2. On a small baking sheet, toss the quartered potatoes with half of the olive oil, rosemary, salt, and pepper

            3. Roast the potatoes for 10 minutes

            4. While the potatoes are roasting, rub the pork chop with the remaining oil, rosemary, salt, and pepper

            5. After 10 minutes, add the pork chop to the baking sheet with the potatoes

            6. Return to the oven and bake for another 15-20 minutes, or until the pork is cooked through and the potatoes are golden
            """,
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
        instructions: """
            ## Instructions

            1. Pour the dressing into the bottom of a mason jar

            2. Layer the other ingredients in the order listed: chicken/egg first, then cucumber, bell peppers, quinoa, and finally pack the spinach in at the top

            3. Seal the jar

            4. When you're ready to eat, just shake it up and pour it into a bowl!
            """,
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
        instructions: """
            ## Instructions

            1. Put all ingredients together in a large pot and heat until soft boil

            2. Reduce heat and simmer for 10-15 minutes

            3. Serve with tortilla chips or chips of choice

            4. Top with shredded cheese, green onions, or other toppings as desired

            > **Crock Pot Option:** Put everything in a crock pot when you won't be home until it's time to eat. Super easy and can be made to your liking!
            """,
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
        instructions: """
            1. **Preheat oven** to 350°F

            2. **Prepare** muffin pan (grease or use liners)

            3. **Fill** muffin cups with batter 2/3 of the way

            4. **Bake** for 20 minutes or until a toothpick inserted in the center comes out clean
            """,
        notes: "Walnuts are optional"
    )
}
