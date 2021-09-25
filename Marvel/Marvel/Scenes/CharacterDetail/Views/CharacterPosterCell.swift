//
//  CharacterPosterCell.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 24.09.2021.
//

import UIKit
import SDWebImage

class CharacterPosterCell: UITableViewCell {

    @IBOutlet weak var ivPoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with image: String) {
        ivPoster.sd_setImage(with: URL(forceString: image))
    }
}
