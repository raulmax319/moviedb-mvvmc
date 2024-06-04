//
// MovieView.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation
import UIKit

final class MovieView: UIView {
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.isHidden = true
    return tableView
  }()

  var viewData = [MovieViewData]()

  init() {
    super.init(frame: .zero)
    backgroundColor = .systemBackground
    setupTableView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    setupConstraints()
  }
}

// MARK: - View
extension MovieView: View {
  func update(with movies: [MovieViewData]) {
    DispatchQueue.main.async { [unowned self] in
      self.viewData = movies
      tableView.reloadData()
      tableView.isHidden = false
    }
  }

  func update(with error: String) {
    print(error)
  }
}

// MARK: - Private
extension MovieView {
  private func setupTableView() {
    addSubview(tableView)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.dataSource = self
    tableView.delegate = self
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor, constant: safeAreaInsets.top),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.widthAnchor.constraint(equalTo: widthAnchor),
      tableView.heightAnchor.constraint(equalTo: heightAnchor)
    ])
  }
}

// MARK: - Tableview
extension MovieView: UITableViewDelegate {}

extension MovieView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewData.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    var content = cell.defaultContentConfiguration()
    content.text = viewData[indexPath.row].title
    cell.contentConfiguration = content

    return cell
  }
}
