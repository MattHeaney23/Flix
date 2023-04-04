//
//  Coordinator.swift
//  Flix
//
//  Created by Matt on 01/04/2022.
//

import Foundation

/// The base protocol for the coordinator. An extension on this protocol would be handy in the future for creating views from xib files or from storyboards
protocol Coordinator {
    func start()
}
