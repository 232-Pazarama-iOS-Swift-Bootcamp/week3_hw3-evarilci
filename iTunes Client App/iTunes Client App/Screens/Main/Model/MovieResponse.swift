//
//  MovieResponse.swift
//  iTunes Client App
//
//  Created by Eymen Varilci on 7.10.2022.
//

import Foundation


struct MovieResponse: Decodable {
        let resultCount: Int?
        let results: [Movie]?
}
