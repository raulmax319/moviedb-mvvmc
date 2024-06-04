//
//  UIWindowExtension.swift
//  MoviedbMVVMC
//
//  Created by Raul Max Moura Monteiro on 04/06/24.
//

import Foundation
import UIKit

extension UIWindow {
  public func make() {
    let coordinator = MovieCoordinator()
    coordinator.start()
    rootViewController = coordinator.entryPoint
    makeKeyAndVisible()
  }
}
