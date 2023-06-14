//
//  ImagePaigeViewController.swift
//  ImagesSearch
//
//  Created by Данік on 30/05/2023.
//

import Foundation
import UIKit
import SDWebImage

class ImagePaigeViewController: UIViewController {
    var imagesArr: [String] = []
    lazy var clickedImageUrl: String = ""
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var pButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var zoomButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImage.sd_setImage(with: URL(string: clickedImageUrl))
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "CustomImageCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: CustomImageCell.identifier)
        pButton.customizeButton()
        searchBar.delegate = self
        
        roundView.roundGrayView()
        searchBar.delegate = self
        
        // Remove the opaque background view
        searchBar.makeTransparent()
        settingsButton.setTitle("", for: .normal)
        settingsButton.addBorder()
        shareButton.addBlueBorder()
        
        zoomButtonOutlet.setTitle("", for: .normal)
        
    }
    
    @IBAction func shareButton(_ sender: UIButton) {
        FuncManager.shareMessage(clickedImageUrl, on: self)
    }
    
}

extension ImagePaigeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArr.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomImageCell.identifier, for: indexPath) as? CustomImageCell else {
            fatalError("Could not dequeue CustomImageCell")
        }
        // Reset the cell's state and content
//        cell.imageView?.image = nil
        cell.buttonOutlet.isHidden = true
        
        let imageURL = imagesArr[indexPath.row]
        if let imageView = cell.imageView {
            imageView.sd_setImage(with: URL(string: imageURL))
        }
        
        return cell
    }
}

extension ImagePaigeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftAndRightPaddings: CGFloat = 10.0
        let numberOfItemsPerRow: CGFloat = 2.0
        let height: CGFloat = 122.0
        
        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: height) // You can change width and height here as pr your requirement
    }
    
}

extension ImagePaigeViewController: UISearchBarDelegate {
    
}

