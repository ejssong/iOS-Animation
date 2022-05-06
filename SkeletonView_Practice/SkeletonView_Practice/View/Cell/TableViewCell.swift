//
//  TableViewCell.swift
//  SkeletonView_Practice
//
//  Created by JIN on 2022/05/04.
//

import Foundation
import UIKit
import SkeletonView

class TableViewCell : UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var desc: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isSkeletonable = true
        self.contentView.isSkeletonable = true 
        self.imgView.isSkeletonable = true
        self.desc.isSkeletonable = true
        self.desc.lastLineFillPercent = 50
        self.desc.linesCornerRadius = 5
        setUI()
    }
    
    func setUI() {
        imgView.layer.cornerRadius = 10
    }
}
