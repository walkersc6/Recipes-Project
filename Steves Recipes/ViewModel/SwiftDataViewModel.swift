//
//  SwiftDataViewModel.swift
//  Sample SwiftData App
//
//  Created by Stephen Liddle on 10/30/25.
//

import SwiftUI
import SwiftData

protocol ContextReferencing {
    init(modelContext: ModelContext)
    func update()
}

@propertyWrapper struct SwiftDataViewModel<VM: ContextReferencing>: DynamicProperty {
    @State var viewModel: VM?
    @Environment(\.modelContext) private var modelContext
    
    var wrappedValue: VM {
        guard let viewModel else {
            fatalError("Attempt to access nil viewModel as wrappedValue")
        }

        return viewModel
    }
    
    var projectedValue: Binding<VM> {
        Binding(
            get: {
                // NEEDSWORK: check whether I can reuse wrappedValue here instead
                guard let viewModel else {
                    fatalError("Attempt to access nil viewModel as projected value")
                }
                return viewModel
            },
            set: { newValue in
                viewModel = newValue
            }
        )
    }
    
    mutating func update() {
        if viewModel == nil {
            _viewModel = State(initialValue: VM(modelContext: modelContext))
        }
        viewModel?.update()
    }
}
