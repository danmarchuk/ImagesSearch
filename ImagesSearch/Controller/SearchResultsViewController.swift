//
//  SearchResultsViewController.swift
//  ImagesSearch
//
//  Created by Данік on 26/05/2023.
//

import Foundation
import UIKit
import SDWebImage

class SearchResultsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    lazy var userInput: String = ""
    var imagesArr: [String] = []
    let imageManager = ImageManager()
    var selectedImageUrl: String = ""
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pButton: UIButton!
    
    @IBOutlet weak var settingsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageManager.fetchImages(using: userInput)
        searchBar.delegate = self
        imageManager.delegate = self
        let nib = UINib(nibName: "CustomImageCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: CustomImageCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        pButton.customizeButton()
        
        roundView.roundGrayView()
        searchBar.delegate = self
        
        // Remove the opaque background view
        searchBar.makeTransparent()
        settingsButton.setTitle("", for: .normal)
        settingsButton.addBorder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromSearchResultsToImagePaige" {
            if let destinationViewController = segue.destination as? ImagePaigeViewController {
                destinationViewController.imagesArr = imagesArr
                destinationViewController.clickedImageUrl = selectedImageUrl
            }
        }
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomImageCell.identifier, for: indexPath) as? CustomImageCell else {
            fatalError("Could not dequeue CustomImageCell")
        }
        let imageURL = imagesArr[indexPath.row]
        cell.imageView?.sd_setImage(with: URL(string: imageURL), completed: nil)
        cell.imageView.layer.cornerRadius = 7
        cell.buttonCallback = {
            FuncManager.shareMessage(self.imagesArr[indexPath.row], on: self)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = indexPath.row
        selectedImageUrl = imagesArr[selectedItem]
        imagesArr.remove(at: selectedItem)
        performSegue(withIdentifier: "fromSearchResultsToImagePaige", sender: self)
    }
    

}
extension SearchResultsViewController: ImageManagerDelegate {
    func didLoadImages(_ manager: ImageManager, images: [String]) {
        DispatchQueue.main.async {
            self.imagesArr = images
            self.collectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
    }
}

extension SearchResultsViewController: UISearchBarDelegate {
    
}

extension SearchResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftAndRightPaddings: CGFloat = 0
        let numberOfItemsPerRow: CGFloat = 1

        let width = (collectionView.frame.width - leftAndRightPaddings) / numberOfItemsPerRow
        return CGSize(width: width, height: 250) // You can change width and height here as per your requirement
    }
}
