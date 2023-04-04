//
//  MovieCell+Views.swift
//  Flix
//
//  Created by Matt on 03/04/2022.
//

import UIKit

///Extension for the UIViews for the cell
extension MovieCell {
    
    //MARK: - Poster
    func addMoviePoster() {
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.alpha = 1
        self.contentView.addSubview(movieImage)
        
        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(equalTo: movieImage.widthAnchor),
            self.contentView.heightAnchor.constraint(equalTo: movieImage.heightAnchor),
            self.contentView.centerXAnchor.constraint(equalTo: movieImage.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: movieImage.centerYAnchor),
        ])
    }
    
    //MARK: - Activity Spinner
    func addSpinningIndicator() {
        activityIndicator.style = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        self.contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    //MARK: - Movie HUD
    func addMovieHUD() {
        let movieHUD = UIView()
        movieHUD.backgroundColor = .black
        movieHUD.alpha = 0.8
        movieHUD.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(movieHUD)
        
        movieTitle.textAlignment = .center
        movieTitle.font = movieTitle.font.withSize(10)
        movieTitle.numberOfLines = 0
        movieTitle.textColor = .white
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(movieTitle)
        
        NSLayoutConstraint.activate([
            movieHUD.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            movieHUD.heightAnchor.constraint(lessThanOrEqualToConstant: 60),
            movieHUD.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            movieHUD.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            movieHUD.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            movieTitle.heightAnchor.constraint(equalTo: movieHUD.heightAnchor, constant: -8),
            movieTitle.widthAnchor.constraint(equalTo: movieHUD.widthAnchor, constant: -8),
            movieTitle.centerXAnchor.constraint(equalTo: movieHUD.centerXAnchor),
            movieTitle.centerYAnchor.constraint(equalTo: movieHUD.centerYAnchor)
        ])
    }
    
    //MARK: - User Favourites
    func addFavouriteHUD() {
        let favouriteHUD = UIView()
        favouriteHUD.backgroundColor = .black
        favouriteHUD.alpha = 0.8
        favouriteHUD.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(favouriteHUD)
        
        let tapGesture = UITapGestureRecognizer(target: viewModel, action: #selector(viewModel?.toggleFavouriteMovie))
        favouriteHUD.addGestureRecognizer(tapGesture)
        
        starImage.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(starImage)
        
        NSLayoutConstraint.activate([
            favouriteHUD.heightAnchor.constraint(equalToConstant: 30),
            favouriteHUD.widthAnchor.constraint(equalToConstant: 30),
            favouriteHUD.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            favouriteHUD.topAnchor.constraint(equalTo: self.topAnchor),
            starImage.heightAnchor.constraint(equalTo: favouriteHUD.heightAnchor, constant: -8),
            starImage.widthAnchor.constraint(equalTo: favouriteHUD.widthAnchor, constant: -8),
            starImage.centerXAnchor.constraint(equalTo: favouriteHUD.centerXAnchor),
            starImage.centerYAnchor.constraint(equalTo: favouriteHUD.centerYAnchor)
        ])
    }
}
