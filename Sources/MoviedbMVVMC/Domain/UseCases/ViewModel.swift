//
//  ViewModel.swift
//  MoviedbMVVMC
//
//  Created by Raul Max Moura Monteiro on 04/06/24.
//

import Foundation

protocol ViewModel {
  func getMovies(completion: @escaping ([Movie?], Bool) -> Void)
}
