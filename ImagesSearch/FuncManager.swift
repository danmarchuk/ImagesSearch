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
    
}
