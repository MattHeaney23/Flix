//
//  MovieCell.swift
//  Flix
//
//  Created by Matt on 01/04/2022.
//

import RxSwift
import UIKit

class MovieCell: UICollectionViewCell {
    
    //MARK: - Cell Identifier
    static var identifier: String = "MovieCell"
    
    //MARK: - Properties
    var viewModel: MovieCellViewModel?
    
    //MARK: - Views
    let movieTitle = UILabel()
    let movieImage = UIImageView()
    let starImage = UIImageView()
    let activityIndicator = UIActivityIndicatorView()
    
    //MARK: - Subscriptions
    private var networkRequestDisposable: Disposable?
    private let disposeBag = DisposeBag()
    
    //MARK: - Cell Prep
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareForReuse()
        createCellEffect()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieImage.image = nil
        self.movieTitle.text = nil
        networkRequestDisposable?.dispose()
        networkRequestDisposable = nil
        viewModel = nil
    }
    
    func setUp(viewModel: MovieCellViewModel) {
        movieTitle.text = viewModel.movie.title
        self.viewModel = viewModel
        
        prepareSubscriptions()
        
        addMoviePoster()
        addSpinningIndicator()
        addMovieHUD()
        addFavouriteHUD()
        
        setFavouriteButton()
        
        if let movieCoverSubscription = viewModel.getMovieCover() {
            networkRequestDisposable = movieCoverSubscription
                .observe(on: MainScheduler())
                .subscribe { coverImage in
                    self.movieImage.image = coverImage
                    self.activityIndicator.stopAnimating()
                } onFailure: { _ in
                    self.movieImage.image = UIImage(named: "cover_unavailable")
                    self.activityIndicator.stopAnimating()
                }
            networkRequestDisposable?.disposed(by: disposeBag)
        } else {
            self.movieImage.image = UIImage(named: "cover_unavailable")
            self.activityIndicator.stopAnimating()
        }
        
        if let title = viewModel.movie.title {
            self.accessibilityIdentifier = "\(title)Cell"
        }
    }
    
    //MARK: - Cell UI
    func createCellEffect() {
        self.backgroundColor = .clear
        self.contentView.layer.cornerRadius = 12
        self.contentView.layer.masksToBounds = true
    }
    
    func prepareSubscriptions() {
        self.viewModel?.favouriteStateChange.subscribe(
            onNext: { [weak self] in
                self?.setFavouriteButton()
            }).disposed(by: disposeBag)
    }
    
    func setFavouriteButton() {
        guard let viewModel = viewModel else {
            return
        }
        if viewModel.isMoveFavourited {
            starImage.image = UIImage(named: "star_full")
        } else {
            starImage.image = UIImage(named: "star_empty")
        }
    }
}
