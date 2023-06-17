//
//  ViewController.swift
//  ImagesSearch
//
//  Created by Данік on 24/05/2023.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var roundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        roundView.roundGrayView()
        searchButton.layer.cornerRadius = 7
        
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
}
