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
        roundView.layer.cornerRadius = 7
        if #available(iOS 13.0, *) {
            roundView.backgroundColor = .systemGray4
        } else {
            // Fallback on earlier versions
        }
        searchButton.layer.cornerRadius = 7
        searchBar.delegate = self
        
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
