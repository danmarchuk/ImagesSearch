//
//  ImageManager.swift
//  ImagesSearch
//
//  Created by Данік on 26/05/2023.
//

import UIKit
import Foundation

import Foundation

protocol ImageManagerDelegate {
    func didLoadImages(_ manager: ImageManager, images: [String])
    func didFailWithError(error: Error)
}

class ImageManager {
    let imagesURL = "https://pixabay.com/api/?key=36723151-a2882345da062400f93be5818&image_type=photo&pretty=true"
    var delegate: ImageManagerDelegate?
    
    func fetchImages(userInput: String){
//        let urlString = "\(imagesURL)&q=\(userInput)"
        let urlString = "\(imagesURL)&q=yellow+flowers"
        performRequest(with: urlString)
    }
    
    var imagesArray: [String] = []
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            // create a URL session
            let session = URLSession(configuration: .default)
            // give session a task
            let task = session.dataTask(with: url) { [weak self] data, response, error in
                if error != nil {
                    self?.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let images = self?.parseJSON(safeData) {
                        self?.delegate?.didLoadImages(self!, images: images)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ imagesData: Data) -> [String]? {
        let decoder = JSONDecoder()
        do {
            let imageData = try decoder.decode(ImagesData.self, from: imagesData)
            let hits = imageData.hits
            var imagesArray: [String] = []
            for hit in hits {
                imagesArray.append(hit.webformatURL)
            }
            print(imagesArray)
            return imagesArray
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
