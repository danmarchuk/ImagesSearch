//
//  ViewController.swift
//  ImagesSearch
//
//  Created by Данік on 24/05/2023.
//

import UIKit
import CropViewController

final class ViewController: UIViewController {
    
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var roundView: UIView!
    
    var imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        roundView.roundGrayView()
        searchButton.layer.cornerRadius = 7
        imagePickerController.delegate = self
        
        // Remove the opaque background view
        searchBar.makeTransparent()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true) // Dismiss the keyboard
        searchBar.resignFirstResponder() // Deselect the text field
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let searchResultsViewController = storyboard.instantiateViewController(withIdentifier: "SearchResultsViewController") as? SearchResultsViewController,
           let text = searchBar.text {
            searchResultsViewController.userInput = text
            self.navigationController?.pushViewController(searchResultsViewController, animated: true)
        }
    }
    
    @IBAction func cropButtonTapped(_ sender: UIButton) {
        presentTheImagePicker()
    }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func presentTheImagePicker() {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let cropViewController = CropViewController(image: pickedImage)
            cropViewController.delegate = self
            picker.dismiss(animated: true) {
                self.present(cropViewController, animated: true)
            }
        }
        dismiss(animated: true)
    }
}

extension ViewController: CropViewControllerDelegate {
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        dismiss(animated: true)
        FuncManager.presentAlertMessage(image: image, on: self)
    }
}
