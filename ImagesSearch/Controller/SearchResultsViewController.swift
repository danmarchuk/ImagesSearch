//
//  SearchResultsViewController.swift
//  ImagesSearch
//
//  Created by Данік on 26/05/2023.
//

import Foundation
import UIKit
import SDWebImage

final class SearchResultsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    lazy var userInput: String = ""
    var imagesArr: [String] = []
    let imageManager = ImageManager()
    let imagePageViewController = ImagePaigeViewController()
    var selectedImageUrl: String = ""
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pButton: UIButton!
    
    @IBOutlet weak var settingsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // fetch images using the user's input from the previous VC
        imageManager.fetchImages(using: userInput.replacingOccurrences(of: " ", with: "+"))
        
        // setup delegates
        delegatesAndDataSourceSetup()
        
        uiSetup()
        
        let nib = UINib(nibName: "CustomImageCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CustomImageCell.identifier)
    }
    
    func uiSetup() {
        pButton.customizeButton()
        roundView.roundGrayView()
        
        settingsButton.setTitle("", for: .normal)
        settingsButton.addBorder()
        
        // set the user input as the searchBar text
        searchBar.text = userInput
        searchBar.makeTransparent()
    }
    
    func delegatesAndDataSourceSetup() {
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        imageManager.delegate = self
        imagePageViewController.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromSearchResultsToImagePaige" {
            if let destinationViewController = segue.destination as? ImagePaigeViewController {
                destinationViewController.imagesArr = imagesArr
                destinationViewController.delegate = self
                destinationViewController.userInput = searchBar.text ?? ""
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarInput = searchBar.text else {return}
        imageManager.fetchImages(using: searchBarInput.replacingOccurrences(of: " ", with: "+"))
        searchBar.resignFirstResponder()
    }
}

extension SearchResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfItemsPerRow: CGFloat = 1.0
        let heightOfTheCell: CGFloat = 250.0
        let orientation = UIApplication.shared.statusBarOrientation
        let leftAndRightPaddings: CGFloat = 15.0
        if orientation == .portrait {
            numberOfItemsPerRow  = 1.0
        } else {
            numberOfItemsPerRow = 2.0
        }
        let width = (collectionView.frame.width - leftAndRightPaddings) / numberOfItemsPerRow
        return CGSize(width: width, height: heightOfTheCell)
    }
}

extension SearchResultsViewController: ImagePaigeDelegate {
    func updateVariable(newVariable: String) {
        searchBar.text = newVariable
        imageManager.fetchImages(using: newVariable.replacingOccurrences(of: " ", with: "+"))
    }
}
