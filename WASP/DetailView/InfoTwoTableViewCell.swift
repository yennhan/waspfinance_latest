//
//  InfoTwoTableViewCell.swift
//  WASP
//
//  Created by Leow Yenn Han on 18/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit

class InfoTwoTableViewCell: UITableViewCell {

    @IBOutlet weak var SecondViewCell: UIView!
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
