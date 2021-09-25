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

    @IBOutlet weak var favoriteImage: UIImageView!
    weak var delegate: ButtonsCellDelegate?
    
    func configureCell(with id: Int) {
        favoriteImage.image = UserDefaultsHelper.Favorites.contains(id) ?
            UIImage(named: "starFilled"): UIImage(named: "star")
    }
    
    @IBAction func btnFavorite(_ sender: Any) {
        delegate?.didTappedFavoriteButton()
    }
    
    @IBAction func btnSave(_ sender: Any) {
        delegate?.didTappedSaveButton()
    }
}
