//
//  FooterCell+Views.swift
//  Flix
//
//  Created by Matt on 03/04/2022.
//

import UIKit

///Extension for the UIViews for the cell
extension FooterCell {
    
    //MARK: - Footer Message
    func addMessageLabel() {
        
        guard let state = viewModel?.state else { return }
        
        loadingMessage.backgroundColor = UIColor.clear
        loadingMessage.text  = state.footerMessage
        loadingMessage.textAlignment = .center
        loadingMessage.font = loadingMessage.font.withSize(10)
        loadingMessage.textColor = .gray
        loadingMessage.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(loadingMessage)
        
        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(lessThanOrEqualTo: loadingMessage.widthAnchor),
            self.contentView.heightAnchor.constraint(equalTo: loadingMessage.heightAnchor),
            self.contentView.centerXAnchor.constraint(equalTo: loadingMessage.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: loadingMessage.centerYAnchor)
        ])
    }
}
