//
//  FoodTableViewCell.swift
//  c2c
//
//  Created by Tushar Singh on 15/03/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var timingLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var sideView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.statusLabel.transform = CGAffineTransform(rotationAngle: .pi/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
