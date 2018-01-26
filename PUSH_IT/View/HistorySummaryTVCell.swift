//
//  HistorySummaryTVCell.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/25/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class HistorySummaryTVCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var today : Date?
    var displayStartDate : Date?

    @IBOutlet weak var historySummaryCV: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        historySummaryCV.dataSource = self
        historySummaryCV.delegate = self
        // Initialization code
        // test helper methods
        
        today = Date()
        displayStartDate = today!.threeWeeksAgoSunday
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}
