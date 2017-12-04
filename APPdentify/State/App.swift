//
//  App.swift
//  APPdentify
//
//  Created by Michael Castillo on 11/5/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import Foundation

enum App {
    
    // Manages changes to the AppState
    static let sharedCore = Core(state: AppState())
    
}

// Holds AppData
struct AppState: State {
    
    var imageOutputs = [ImageOutput]()
    var error: Error?
    
    mutating func react(to event: Event) {
        switch event {
        case let event as ImageOutputCreated:
            imageOutputs.append(event.imageOutput)
        case let event as ImageProcessingError:
            self.error = event.error
        default:
            break
        }
    }
    
}

struct ImageOutputCreated: Event {
    var imageOutput: ImageOutput
}

struct ImageProcessingError: Event {
    var error: Error
}
