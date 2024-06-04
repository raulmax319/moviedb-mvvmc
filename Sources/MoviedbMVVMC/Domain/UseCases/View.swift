//
// View.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation

protocol View: AnyObject {
  func update(with movies: [MovieViewData])
  func update(with error: String)
}
