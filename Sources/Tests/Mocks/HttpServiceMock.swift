//
// HttpServiceMock.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation
import XCTest
@testable import MoviedbMVVMC

final class HttpServiceMock: Service {
  private(set) lazy var httpClient: HttpRequest? = {
    let configuration = URLSessionConfiguration.default
    configuration.protocolClasses = [URLProtocolMock.self]
    let urlSession = URLSession(configuration: configuration)
    return URLSessionHttpClient(with: URL(string: "http://localmock:3333")!, session: urlSession)
  }()

  var expectation: XCTestExpectation?

  func getMovies(completion: @escaping (Result<MovieData, Error>) -> Void) {
    httpClient?.request { (result: Result<Data, Error>) in
      switch result {
      case .success(let success):
        completion(.success(self.handleData(success)))
      case .failure(let reason):
        completion(.failure(reason))
      }
      self.expectation?.fulfill()
      self.expectation = nil
    }
  }

  private func handleData(_ data: Data) -> MovieData {
    guard let model = try? JSONDecoder().decode(MovieData.self, from: data) else {
      return MovieData(data: [])
    }

    return model
  }
}
