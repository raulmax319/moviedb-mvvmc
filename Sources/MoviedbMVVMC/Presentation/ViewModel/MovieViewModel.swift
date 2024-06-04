//
//  MovieViewModel.swift
//  MoviedbMVVMC
//
//  Created by Raul Max Moura Monteiro on 04/06/24.
//

import Foundation

final class MovieViewModel: ViewModel {
  private let service: Service

  init(service: Service = RemoteService()) {
    self.service = service
  }

  func getMovies(completion: @escaping ([Movie?], Bool) -> Void) {
    service.getMovies { result in
      guard case let .success(movies) = result else {
        completion([], false)
        return
      }

      completion(movies.data, true)
    }
  }
}
