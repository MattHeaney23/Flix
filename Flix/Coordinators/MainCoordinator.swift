//
//  MainCoordinator.swift
//  Flix
//
//  Created by Matt on 01/04/2022.
//

import UIKit

///The main coordinator in the app, controlling the navigation between views. This allows the logic to be removed from view controllers, keeping all navigation flexible, scalable and maintainable
class MainCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        let mainViewController = MainViewController()
        mainViewController.mainCoordinatorDelegate = self
        navigationController.pushViewController(mainViewController, animated: false)
    }
}

extension MainCoordinator: MainCoordinatorDelegate {
    func moveToDetailsView(movieDetails: MovieDetails) {
        let viewModel = DetailsViewModel(movieDetails: movieDetails)
        let detailsViewController = DetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}
