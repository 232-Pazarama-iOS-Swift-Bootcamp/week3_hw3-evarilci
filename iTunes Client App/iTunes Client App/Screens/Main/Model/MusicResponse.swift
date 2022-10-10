//
//  MusicRespond.swift
//  iTunes Client App
//
//  Created by Eymen Varilci on 6.10.2022.
//

import Foundation

struct MusicResponse: Decodable {
    let resultCount: Int?
    let results: [Music]?
}
