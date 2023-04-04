//
//  DetailsViewController+Views.swift
//  Flix
//
//  Created by Matt on 03/04/2022.
//

import UIKit
import RxSwift

extension DetailsViewController {
    
    //MARK: - Scroll View
    func setupScrollView(){
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func setupViews(){
        
        let movieCover = getMoveCoverImageView()
        let titleLabel = getTitleLabelView()
        let infoLabel = getInfoLabelView()
        let movieOverviewLabel = getMovieOverviewLabelView()
        
        let stackView = getMovieDetailsStackView()
        
        stackView.addArrangedSubview(movieCover)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(getSeparator())
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(getSeparator())
        stackView.addArrangedSubview(movieOverviewLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -32),
            movieOverviewLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -32),
            infoLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -32),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    //MARK: - Movie Cover
    func getMoveCoverImageView() -> UIImageView{
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        
        if let movieCoverSubscription = viewModel.getMovieCover() {
            movieCoverSubscription
                .observe(on: MainScheduler())
                .subscribe { coverImage in
                    imageView.image = coverImage
                } onFailure: { _ in
                    imageView.image = nil
                }
                .disposed(by: disposeBag)
        } else {
            imageView.image = nil
        }
        
        return imageView
    }
    
    //MARK: - Stack View
    func getMovieDetailsStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 12
        stackView.backgroundColor = .clear
        return stackView
    }
    
    //MARK: - Movie Title
    func getTitleLabelView() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = viewModel.movieDetails.title ?? ""
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.darkGray
        titleLabel.textAlignment = .center
        titleLabel.font = titleLabel.font.withSize(30)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.accessibilityIdentifier = "detailsTitleLabel"
        return titleLabel
    }
    
    //MARK: - Movie Info
    func getInfoLabelView() -> UILabel {
        let infoLabel = UILabel()
        infoLabel.text = "Rating: \(viewModel.movieRating) | Release: \(viewModel.movieReleaseDate)"
        infoLabel.numberOfLines = 0
        infoLabel.sizeToFit()
        infoLabel.textColor = UIColor.darkGray
        infoLabel.textAlignment = .center
        infoLabel.font = infoLabel.font.withSize(12)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        return infoLabel
    }
    
    //MARK: - Movie Overview
    func getMovieOverviewLabelView() -> UILabel {
        let movieOverviewLabel = UILabel()
        if let movieOverview = viewModel.movieDetails.overview {
            movieOverviewLabel.text = "\(movieOverview)"
        }
        movieOverviewLabel.numberOfLines = 0
        movieOverviewLabel.sizeToFit()
        movieOverviewLabel.textColor = UIColor.gray
        movieOverviewLabel.translatesAutoresizingMaskIntoConstraints = false
        return movieOverviewLabel
    }
    
    //MARK: - Separator
    func getSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .gray
        separator.alpha = 0.5
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.widthAnchor.constraint(equalToConstant: 250).isActive = true
        return separator
    }
}
