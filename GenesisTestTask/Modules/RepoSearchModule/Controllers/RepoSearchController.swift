//
//  ViewController.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RepoSearchController: UIViewController, ControllerType {
  
  //MARK: - Properties
  
  typealias ViewModel = RepoSearchControllerViewModel
  var viewModel: RepoSearchControllerViewModel!
	private let disposeBag = DisposeBag()
	
	//MARK: - UI
	
	@IBOutlet weak var repoListTableView: UITableView!
	@IBOutlet weak var searchTextField: UITextField!
	@IBOutlet weak var submitButton: UIButton!
	
	//MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
		
		configureTableView()
    configure(with: viewModel)
  }
  
  //MARK: - Functions
  
  func configure(with viewModel: RepoSearchControllerViewModel) {
		
		viewModel.output.repos
			.bind(to: self.repoListTableView.rx
				.items(cellIdentifier: RepoListTableViewCell.reuseIdentifier)) { row, element, cell in
					if let cell = cell as? RepoListTableViewCell {
						cell.fill(with: element)
					}
		}.disposed(by: disposeBag)
		
		repoListTableView.rx
			.modelSelected(RepoListTableViewCellViewModel.self)
			.do(onNext: { [unowned self] _ in
				self.repoListTableView.indexPathsForSelectedRows?.forEach({ (idx) in
					self.repoListTableView.deselectRow(at: idx, animated: true)
				})
			})
			.subscribe(onNext: { (repo) in
				print(repo.output.repoURL)
			})
			.disposed(by: disposeBag)
  }
	
	private func configureTableView() {
		repoListTableView.estimatedRowHeight = 100
		repoListTableView.rowHeight = UITableViewAutomaticDimension
		repoListTableView.registerReuseableCell(RepoListTableViewCell.self)
	}
  
  deinit {
    print("\(self) dealloc")
  }
}
