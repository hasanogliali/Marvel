//
//  GridCharacterCell.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 21.09.2021.
//

import UIKit
import SDWebImage

class GridCharacterCell: UICollectionViewCell {
    @IBOutlet weak var ivCharacter: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSeriesCount: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(with model: CharacterList.FetchCharacters.ViewModel.CharacterCellModel?) {
        labelName.text = model?.name
        labelSeriesCount.text = model?.seriesCount
        ivCharacter.sd_imageIndicator = SDWebImageActivityIndicator.large
        ivCharacter.sd_setImage(with: URL(string: model?.image ?? ""))
    }
}
