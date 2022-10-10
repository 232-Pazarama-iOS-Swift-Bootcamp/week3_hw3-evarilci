//
//  Movie.swift
//  iTunes Client App
//
//  Created by Eymen Varilci on 7.10.2022.
//

import Foundation


struct Movie: Decodable {
    
    let director: String?
    let movieName: String?
    let artwork: URL?
    let country: String?
    let genre: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case director = "artistName"
        case movieName = "trackName"
        case artwork = "artworkUrl100"
        case country 
        case genre = "primaryGenreName"
        case description = "longDescription"
    }
}
