//
//  CustomImageCell.swift
//  ImagesSearch
//
//  Created by Данік on 26/05/2023.
//

import UIKit

class CustomImageCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttonOutlet.setTitle("", for: .normal)
    }
    
    @IBOutlet weak var buttonOutlet: UIButton!
    static let identifier = "CustomImageCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
}
