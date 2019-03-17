//
//  TopBondsCollectionViewCell.swift
//  WASP
//
//  Created by Leow Yenn Han on 11/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit
import Charts

class TopBondsCollectionViewCell: UICollectionViewCell, ChartViewDelegate {

    @IBOutlet weak var theLineCharts: LineChartView!
    @IBOutlet weak var bondPrice: UILabel!
    
}
