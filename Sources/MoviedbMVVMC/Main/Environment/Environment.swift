//
//  Environment.swift
//  MoviedbMVVMC
//
//  Created by Raul Max Moura Monteiro on 04/06/24.
//

import Foundation

struct Environment {
  enum VariableKeys: String {
    case baseUrl = "BASE_API_URL"
  }

  static let instance = Environment()
  var environment: [String: Any]? {
    Bundle.main.object(forInfoDictionaryKey: "Environment Settings") as? [String : Any]
  }

  private init() {
    // intentionally not implemented
  }

  func getValue(forKey key: VariableKeys) -> String {
    environment?[key.rawValue] as? String ?? String()
  }
}
