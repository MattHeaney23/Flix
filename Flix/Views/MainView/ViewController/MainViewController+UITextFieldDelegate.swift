//
//  MainViewController+UITextFieldDelegate.swift
//  Flix
//
//  Created by Matt on 03/04/2022.
//

import UIKit

///Extension for the UITextFieldDelegate for the MainViewController
extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.viewModel.entererSearchTerm = textField.text ?? ""
        viewModel.prepareForNewResults()
        viewModel.getMovies()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
}
