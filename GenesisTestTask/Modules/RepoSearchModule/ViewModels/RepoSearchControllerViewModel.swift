//
//  RepoSearchControllerViewModel.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

class RepoSearchControllerViewModel: ViewModelType {
  
  // MARK: - Properties
  
  let input: Input
  let output: Output
  
  struct Input {
  }
  struct Output {
  }
  
  // MARK: - Init and deinit
  init() {
    input = Input()
    output = Output()
  }
  deinit {
    print("\(self) dealloc")
  }
}
