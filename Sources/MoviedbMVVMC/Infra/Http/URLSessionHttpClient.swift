//
// URLSessionHttpClient.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation

final class URLSessionHttpClient: HttpRequest {
  private let session: URLSession
  private let url: URL
  private lazy var request: URLRequest = {
    return URLRequest(url: url)
  }()

  public init(
    with url: URL,
    session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
  ) {
    self.url = url
    self.session = session
  }

  func request(completion: @escaping (Result<Data, Error>) -> Void) {
#if DEBUG
    guard 
      let path = Bundle.main.path(forResource: "movies", ofType: "json"),
      let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    else {
      completion(.failure(NSError(domain: "Invalid JSON", code: -1)))
      return
    }

    completion(.success(data))
#else
    let task = session.dataTask(with: request) { data, _, error in
      guard let data, error == nil else {
        completion(.failure(URLError(.cannotDecodeRawData)))
        return
      }

      completion(.success(data))
    }
    task.resume()
#endif
  }
}
