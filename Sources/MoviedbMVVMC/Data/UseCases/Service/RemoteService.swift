//
// RemoteService.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation

final class RemoteService: Service {
  private(set) lazy var httpClient: HttpRequest? = {
    guard
      let url = URL(string: Environment.instance.getValue(forKey: .baseUrl))
    else {
      return nil
    }

    return URLSessionHttpClient(with: url)
  }()

  private let decoder: JSONDecoder = JSONDecoder()

  func getMovies(completion: @escaping (Result<MovieData, Error>) -> Void) {
    httpClient?.request { [unowned self] result in
      guard case let .success(data) = result else {
        completion(.failure(NSError()))
        return
      }

      guard let model = try? decoder.decode(MovieData.self, from: data) else {
        completion(.failure(NSError()))
        return
      }

      completion(.success(model))
    }
  }
}
