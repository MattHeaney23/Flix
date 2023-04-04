//
//  FooterCell.swift
//  Flix
//
//  Created by Matt on 02/04/2022.
//

import RxSwift
import UIKit

class FooterCell: UICollectionViewCell {
    
    //MARK: - Cell Identifier
    static var identifier: String = "FooterCell"
    
    //MARK: - Properties
    var viewModel: FooterCellViewModel?
    
    //MARK: - Views
    var loadingMessage = UILabel()
    
    //MARK: - Cell Prep
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareForReuse()
    }
    
    func setup(viewModel: FooterCellViewModel) {
        self.viewModel = viewModel
        addMessageLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loadingMessage.text = ""
    }
}
