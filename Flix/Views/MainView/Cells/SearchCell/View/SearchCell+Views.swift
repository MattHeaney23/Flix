//
//  SearchCell+Views.swift
//  Flix
//
//  Created by Matt on 03/04/2022.
//

import UIKit

///Extension for the UIViews for the cell
extension SearchCell {
    
    //MARK: - Search Bar
    func addSearchBar() {
        guard let viewModel = searchCellViewModel else { return }
        textField.placeholder = viewModel.searchFieldPlaceholder
        textField.text = viewModel.startingTerm
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = searchBarDelegate
        self.contentView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 8),
            textField.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            textField.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
}
