//
//  MainViewModelState.swift
//  Flix
//
//  Created by Matt on 03/04/2022.
//

import Foundation

enum MainViewModelState {
    case ready
    case loading
    case allResultsLoaded
    case error
    
    var footerMessage: String {
        switch self {
        case .ready: return "All up to date!"
        case .loading: return "Give us a few ticks, we're loading more Flixs (:"
        case .allResultsLoaded: return "That's all the Flixs!"
        case .error: return "Please try again in a moment."
        }
    }
}
