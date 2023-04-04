//
//  MainCoordinatorDelegate.swift
//  Flix
//
//  Created by Matt on 01/04/2022.
//

import Foundation

///The delegation protocol for the Main Coordinator
protocol MainCoordinatorDelegate {
    func moveToDetailsView(movieDetails: MovieDetails)
}
