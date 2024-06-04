//
// MovieViewController.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation
import UIKit

final class MovieViewController: UIViewController {
  lazy var movieView: MovieView = {
    return MovieView()
  }()

  var viewModel: ViewModel?

  override func loadView() {
    super.loadView()

    view = movieView
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    setup()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

    view.subviews.forEach { $0.removeFromSuperview() }
  }

  private func setup() {
    viewModel?.getMovies { [weak self] movies, success in
      guard success else {
        return
      }

      let viewData = movies.compactMap { $0 }.map { MovieViewData(title: $0.title) }
      self?.movieView.update(with: viewData)
    }
  }
}
