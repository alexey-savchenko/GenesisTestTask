//
//  RepoListTableViewCell.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit
import SDWebImage

class RepoListTableViewCell: UITableViewCell, ReusableCellType {
	typealias CellViewModel = RepoListTableViewCellViewModel
	
	@IBOutlet weak var ownerUserpicImageView: UIImageView!
	@IBOutlet weak var repoNameLabel: UILabel!
	@IBOutlet weak var starsLabel: UILabel!
	@IBOutlet weak var languageLabel: UILabel!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
	
		ownerUserpicImageView.layer.cornerRadius = 30
		ownerUserpicImageView.clipsToBounds = true
	}
	
	func fill(with cellViewModel: RepoListTableViewCellViewModel) {
		ownerUserpicImageView.sd_setImage(with: cellViewModel.output.ownerUserpicURL)
		repoNameLabel.text = cellViewModel.output.repoNameString
		starsLabel.text = cellViewModel.output.starsCountString
		languageLabel.text = cellViewModel.output.repoLanguageString
	}
}
