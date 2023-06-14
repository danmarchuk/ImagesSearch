//
//  ViewController.swift
//  ImagesSearch
//
//  Created by Данік on 24/05/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var roundView: UIView!
    var imageManager = ImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        roundView.layer.cornerRadius = 7
        if #available(iOS 13.0, *) {
            roundView.backgroundColor = .systemGray4
        } else {
            // Fallback on earlier versions
        }
        searchButton.layer.cornerRadius = 7
        searchBar.delegate = self
//        searchBar.barTintColor =  .clear
        
        // Remove the opaque background view
        searchBar.backgroundImage = UIImage()
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.clear
        }
        imageManager.fetchImages(using: "go")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true) // Dismiss the keyboard
        // Replace 'textField' with the actual reference to your text field
        searchBar.resignFirstResponder() // Deselect the text field
    }

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "fromMainToSearchResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromMainToSearchResults" {
            if let destinationViewController = segue.destination as? SearchResultsViewController,
            let text = searchBar.text {
                destinationViewController.userInput = text
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
}


