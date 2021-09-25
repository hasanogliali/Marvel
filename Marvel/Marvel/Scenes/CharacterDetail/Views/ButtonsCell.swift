//
//  ButtonsCell.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 25.09.2021.
//

import UIKit

protocol ButtonsCellDelegate: AnyObject {
    func didTappedSaveButton()
    func didTappedFavoriteButton()
}

class ButtonsCell: UITableViewCell {

    weak var delegate: ButtonsCellDelegate?
    
    @IBAction func btnFavorite(_ sender: Any) {
        delegate?.didTappedFavoriteButton()
    }
    
    @IBAction func btnSave(_ sender: Any) {
        delegate?.didTappedSaveButton()
    }
}
