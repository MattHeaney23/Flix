//
//  SearchCell.swift
//  Flix
//
//  Created by Matt on 02/04/2022.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    //MARK: - Cell Identifier
    static var identifier: String = "SearchCell"
    
    //MARK: - Properties
    weak var searchBarDelegate: UITextFieldDelegate?
    var searchCellViewModel: SearchCellViewModel?
    
    //MARK: - Views
    let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    //MARK: - Cell Prep
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareForReuse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(searchCellViewModel: SearchCellViewModel, searchBarDelegate: UITextFieldDelegate?) {
        self.searchCellViewModel = searchCellViewModel
        self.searchBarDelegate = searchBarDelegate
        addSearchBar()
    }
    
    override func prepareForReuse() {
        searchBarDelegate = nil
        super.prepareForReuse()
    }
}
