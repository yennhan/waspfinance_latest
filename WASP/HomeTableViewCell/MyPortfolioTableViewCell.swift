//
//  MyPortfolioTableViewCell.swift
//  WASP
//
//  Created by Leow Yenn Han on 12/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit

class MyPortfolioTableViewCell: UITableViewCell {

    @IBOutlet weak var topSupporterCV: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

