//
//  StinkyTableViewCell.swift
//  Kiley Stinks
//
//  Created by Logan Melton on 2/28/21.
//

import UIKit

class StinkyTableViewCell: UITableViewCell {

  @IBOutlet weak var stinkLabel: UILabel!
  @IBOutlet weak var stinkDetails: UILabel!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
