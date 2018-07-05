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
	
	func fill(with model: RepoListTableViewCellViewModel) {
		ownerUserpicImageView.sd_setImage(with: model.output.ownerUserpicURL)
		repoNameLabel.text = model.output.repoNameString
		starsLabel.text = model.output.starsCountString
		languageLabel.text = model.output.repoLanguageString
	}
}
