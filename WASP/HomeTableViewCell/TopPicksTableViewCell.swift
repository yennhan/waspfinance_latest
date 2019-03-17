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

/*extension TopPicksTableViewCell: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout  = theCV?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludeSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offSet = targetContentOffset.pointee
        let index = (offSet.x + scrollView.contentInset.left) / cellWidthIncludeSpacing
        
        let roundedIndex = round(index)
        offSet = CGPoint(x: roundedIndex * cellWidthIncludeSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offSet
        
    }
}*/
