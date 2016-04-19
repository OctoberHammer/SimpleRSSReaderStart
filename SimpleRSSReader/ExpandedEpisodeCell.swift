//
//  ExpandedEpisodeCell.swift
//  SimpleRSSReader
//
//  Created by Ocotober Hammer on 4/17/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class ExpandedEpisodeCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var fullContentLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
