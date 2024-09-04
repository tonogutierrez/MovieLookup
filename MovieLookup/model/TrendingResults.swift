//
//  TrendingResults.swift
//  MovieLookup
//
//  Created by Antonio Gutierrez on 03/09/24.
//

import Foundation

struct TrendingResults: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}
