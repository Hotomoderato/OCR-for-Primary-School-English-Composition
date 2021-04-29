//
//  HistoryScoreCell.swift
//  LoTsProject
//
//  Created by lots on 2021/2/26.
//
//

import UIKit

class HistoryScoreCell: UITableViewCell {

    // MARK: - LazyLoad
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
