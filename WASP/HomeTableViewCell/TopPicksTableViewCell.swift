//
//  TopPicksTableViewCell.swift
//  WASP
//
//  Created by Leow Yenn Han on 14/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit

class TopPicksTableViewCell: UITableViewCell {

    @IBOutlet weak var theCV: UICollectionView!
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

