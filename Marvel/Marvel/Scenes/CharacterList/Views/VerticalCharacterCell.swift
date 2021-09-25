//
//  VerticalCharacterCell.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 20.09.2021.
//

import UIKit
import SDWebImage

class VerticalCharacterCell: UICollectionViewCell {

    @IBOutlet weak var ivCharacter: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSeriesCount: UILabel!
    @IBOutlet weak var ivFavorite: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(with model: CharacterList.FetchCharacters.ViewModel.CharacterCellModel?) {
        labelName.text = model?.name
        labelSeriesCount.text = model?.seriesCount
        ivCharacter.sd_imageIndicator = SDWebImageActivityIndicator.large
        ivCharacter.sd_setImage(with: URL(string: model?.image ?? ""))
        ivFavorite.image = UserDefaultsHelper.Favorites.contains(model?.id ?? 0) ?
            UIImage(named: "starFilled"): UIImage(named: "star")
    }
}
