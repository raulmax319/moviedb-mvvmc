//
// MovieCoordinator.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation
import UIKit

final class MovieCoordinator: Coordinator {
  private(set) var entryPoint: UIViewController?
  var viewModel: ViewModel

  init(viewModel: ViewModel = MovieViewModel()) {
    self.viewModel = viewModel
  }

  func start() {
    let vc = MovieViewController()
    vc.viewModel = viewModel
    entryPoint = UINavigationController(rootViewController: vc)
  }
}
