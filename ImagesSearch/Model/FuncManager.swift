//
//  FuncManager.swift
//  ImagesSearch
//
//  Created by Данік on 15/06/2023.
//

import Foundation
import UIKit

struct FuncManager {
    static func shareMessage(_ content: String, on viewController: UIViewController) {
        let message = content
        let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        viewController.present(activityController, animated: true)
    }
    
    static func presentAlertMessage(image: UIImage, on viewController: UIViewController) {
        let alertController = UIAlertController(title: "Save the Image", message: "Do you want to save the cropped image?", preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }

        let noAction = UIAlertAction(title: "No", style: .cancel) { _ in
        }

        // add the actions to the alert controller
        alertController.addAction(yesAction)
        alertController.addAction(noAction)

        // present the alert controller
        viewController.present(alertController, animated: true, completion: nil)
    }
}
