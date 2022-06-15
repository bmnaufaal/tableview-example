//
//  Books.swift
//  DayThree
//
//  Created by Berlian on 15/06/22.
//

import Foundation

struct Books : Decodable {
    let title: String
    let authors: [String]
    let isbn: String?
    let thumbnailUrl: String?
}
