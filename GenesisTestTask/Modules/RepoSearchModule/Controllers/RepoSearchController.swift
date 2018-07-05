//
//  ViewController.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

class RepoSearchController: UIViewController, ControllerType {
  
  //MARK: - Properties
  
  typealias ViewModel = RepoSearchControllerViewModel
  var viewModel: RepoSearchControllerViewModel!
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure(with: viewModel)
  }
  
  //MARK: - Functions
  
  func configure(with viewModel: RepoSearchControllerViewModel) {
    
  }
  
  deinit {
    print("\(self) dealloc")
  }
}
