//
//  DetailsViewController.swift
//  Flix
//
//  Created by Matt on 01/04/2022.
//

import RxSwift
import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: - Views
    let contentView = UIView()
    let favouriteButton = UIButton()
    
    //MARK: - Subscriptions
    var viewModel: DetailsViewModel
    let disposeBag = DisposeBag()
    
    //MARK: - View Launch
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        prepareNavBar()
        prepareSubscriptions()
        setupViews()
        setupScrollView()
    }
    
    //MARK: - Prepare Subscriptions
    func prepareSubscriptions() {
        self.viewModel.favouriteStateChange.subscribe(
            onNext: { [weak self] in
                guard let self = self else { return }
                self.setFavouriteButton()
            }).disposed(by: disposeBag)
    }
    
    //MARK: - Prepare UI
    func prepareNavBar() {
        favouriteButton.tintColor = .black
        favouriteButton.addTarget(viewModel, action: #selector(viewModel.toggleMovieFavourited), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: favouriteButton)
        self.navigationItem.rightBarButtonItem = barButton
        setFavouriteButton()
        
        self.title = viewModel.movieDetails.title
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func setFavouriteButton() {
        if viewModel.isMovieFavourited {
            favouriteButton.setImage(UIImage(named: "star_full"), for: .normal)
        } else {
            let image = UIImage(named: "star_empty")?.withRenderingMode(.alwaysTemplate)
            favouriteButton.setImage(image, for: .normal)
            favouriteButton.tintColor = .black
        }
    }
}
