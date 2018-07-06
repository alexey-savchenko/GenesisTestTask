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

class RepoSearchController: UIViewController, ControllerType, RepoWebPresenter {
  
  //MARK: - Properties
  
  typealias ViewModel = RepoSearchControllerViewModel
  var viewModel: RepoSearchControllerViewModel!
	private let disposeBag = DisposeBag()
	private lazy var isValidForm: Observable<Bool> = {
		return searchTextField.rx.text.asObservable().map { !$0!.isEmpty }
	}()
	
	//MARK: - UI
	
	@IBOutlet private weak var repoListTableView: UITableView!
	@IBOutlet private weak var searchTextField: UITextField!
	@IBOutlet private weak var submitButton: UIButton!
	private var spinner: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
	private lazy var spinnerBarItem: UIBarButtonItem = {
		return UIBarButtonItem(customView: spinner)
	}()
	private let historyBarItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.bookmarks, target: nil, action: nil)
	
	//MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
		
		configureUI()
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
		
		viewModel.output.isQuerying
			.subscribe(spinner.rx.isAnimating)
			.disposed(by: disposeBag)
		
		viewModel.output.isQuerying
			.subscribe(onNext: { [unowned self] (value) in
				switch value {
				case true:
					self.submitButton.setTitle("Cancel", for: .normal)
				case false:
					self.submitButton.setTitle("Search", for: .normal)
				}
			})
			.disposed(by: disposeBag)
		
		viewModel.output.errors
			.subscribe(onNext: { [unowned self] error in
				self.presentError(error)
			})
			.disposed(by: disposeBag)
		
		searchTextField.rx.text.asObservable()
			.map { $0! }
			.subscribe(viewModel.input.searchQuery)
			.disposed(by: disposeBag)
		
		submitButton.rx.tap.asObservable()
			.debounce(0.2, scheduler: MainScheduler.instance)
			.withLatestFrom(viewModel.output.isQuerying)
			.filter { $0 == true }
			.map { _ in () }
			.subscribe(viewModel.input.cancelSearch)
			.disposed(by: disposeBag)
		
		submitButton.rx.tap.asObservable()
			.debounce(0.2, scheduler: MainScheduler.instance)
			.withLatestFrom(viewModel.output.isQuerying)
			.filter { $0 == false }
			.do(onNext: { [unowned self] _ in
				self.searchTextField.resignFirstResponder()
			})
			.map { _ in () }
			.subscribe(viewModel.input.startSearch)
			.disposed(by: disposeBag)
		
		repoListTableView.rx
			.modelSelected(RepoListTableViewCellViewModel.self)
			.do(onNext: { [unowned self] _ in
				self.repoListTableView.indexPathsForSelectedRows?.forEach({ (idx) in
					self.repoListTableView.deselectRow(at: idx, animated: true)
				})
			})
			.subscribe(onNext: { [unowned self] (repo) in
				self.presentRepoWebPage(repo.output.repoURL)
			})
			.disposed(by: disposeBag)
		
		historyBarItem.rx.tap.asObservable()
			.subscribe(viewModel.input.showSearchHistory)
			.disposed(by: disposeBag)
  }
	
	private func configureTableView() {
		repoListTableView.estimatedRowHeight = 100
		repoListTableView.keyboardDismissMode = .interactive
		repoListTableView.rowHeight = UITableViewAutomaticDimension
		repoListTableView.registerReuseableCell(RepoListTableViewCell.self)
	}
	
	private func configureUI() {
		configureTableView()
		spinner.hidesWhenStopped = true
		navigationItem.title = "GitHub search"
		navigationItem.leftBarButtonItems = [spinnerBarItem]
		navigationItem.rightBarButtonItems = [historyBarItem]
		isValidForm.subscribe(submitButton.rx.isEnabled).disposed(by: disposeBag)
	}
  
  deinit {
    print("\(self) dealloc")
  }
}
