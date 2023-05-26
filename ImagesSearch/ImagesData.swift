//
//  ImagesData.swift
//  ImagesSearch
//
//  Created by Данік on 26/05/2023.
//

import Foundation

struct ImagesData: Decodable {
    let total: Int
    let totalHits: Int
    let hits: [ImageHit]
}

struct ImageHit: Decodable {
    let webformatURL: String
}
