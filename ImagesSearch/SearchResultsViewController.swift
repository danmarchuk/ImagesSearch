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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageManager.fetchImages(using: userInput)
        imageManager.delegate = self
        let nib = UINib(nibName: "CustomImageCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: CustomImageCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
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
        imagesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomImageCell.identifier, for: indexPath) as? CustomImageCell else {
            fatalError("Could not dequeue CustomImageCell")
        }
        
        let imageURL = imagesArr[indexPath.row]
        cell.imageView?.sd_setImage(with: URL(string: imageURL), completed: nil)
        
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
