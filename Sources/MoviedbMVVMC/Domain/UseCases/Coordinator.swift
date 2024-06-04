//
// Coordinator.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
  var entryPoint: UIViewController? { get }
  var viewModel: ViewModel { get }
  func start()
}
