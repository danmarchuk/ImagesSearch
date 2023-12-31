//
//  CustomImageCell.swift
//  ImagesSearch
//
//  Created by Данік on 26/05/2023.
//

import UIKit

final class CustomImageCell: UICollectionViewCell {
    @IBOutlet weak var buttonOutlet: UIButton!
    static let identifier = "CustomImageCell"
    @IBOutlet weak var imageView: UIImageView!
    var buttonCallback: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttonOutlet.setTitle("", for: .normal)
    }
    
    @IBAction func shareButtonClicked(_ sender: UIButton) {
        buttonCallback?()
    }
}
