//
//  ImagePaigeViewController.swift
//  ImagesSearch
//
//  Created by Данік on 30/05/2023.
//

import Foundation
import UIKit
import SDWebImage

protocol ImagePageDelegate: AnyObject {
    func updateVariable(newVariable: String)
}

final class ImagePageViewController: UIViewController {
    
    var imagesArr: [String] = []
    lazy var clickedImageUrl: String = ""
    lazy var userInput: String = ""
    let imageManager = ImageManager()
    weak var delegate: ImagePageDelegate?
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
        let nib = UINib(nibName: "CustomImageCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CustomImageCell.identifier)
        uiSetup()
        delegatesAndDataSourceSetup()
    }
    
    func uiSetup() {
        pButton.customizeButton()
        searchBar.text = userInput
        roundView.roundGrayView()
        searchBar.makeTransparent()
        settingsButton.setTitle("", for: .normal)
        settingsButton.addBorder()
        shareButton.addBlueBorder()
        zoomButtonOutlet.setTitle("", for: .normal)
        mainImage.sd_setImage(with: URL(string: clickedImageUrl))
    }
    
    func delegatesAndDataSourceSetup() {
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func shareButton(_ sender: UIButton) {
        FuncManager.shareMessage(clickedImageUrl, on: self)
    }
    
    @IBAction func downloadButtonClicked(_ sender: UIButton) {
        if let image = mainImage.image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
    
    @IBAction func zoomButtonClicked(_ sender: UIButton) {
        let imageViewController = ZoomViewController()
        imageViewController.imageURL = clickedImageUrl
        
        // Present the image view controller
        self.navigationController?.pushViewController(imageViewController, animated: true)
    }
}

extension ImagePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomImageCell.identifier, for: indexPath) as? CustomImageCell else {
            return UICollectionViewCell()
        }
        
        cell.buttonOutlet.isHidden = true
        
        let imageURL = imagesArr[indexPath.row]
        if let imageView = cell.imageView {
            imageView.sd_setImage(with: URL(string: imageURL))
        }
        return cell
    }
}

extension ImagePageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftAndRightPaddings: CGFloat = 10.0
        let numberOfItemsPerRow: CGFloat = 2.0
        let height: CGFloat = 122.0
        
        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: height)
    }
}

extension ImagePageViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarInput = searchBar.text else {return}
        delegate?.updateVariable(newVariable: searchBarInput)
        searchBar.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
    }
}
