/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An extension that creates a sample model container to use when previewing
 views in Xcode.
*/

import SwiftData

extension ModelContainer {
    static var sample: () throws -> ModelContainer = {
        // Ingredient.self from Claude: https://claude.ai/share/e23fa34b-5032-43d6-ab53-0ead2e09bab8
        let schema = Schema([Category.self, Recipe.self, Ingredient.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [configuration])
        Task { @MainActor in
            Category.insertSampleData(modelContext: container.mainContext)
        }
        return container
    }
}
