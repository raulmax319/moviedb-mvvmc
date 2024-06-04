//
// Movie.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation

struct Movie: Decodable {
  var title: String
}

struct MovieData: Decodable {
  var data: [Movie]
}
