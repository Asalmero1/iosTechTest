//
//  DetailCell.swift
//  iOSTechTestSwift
//
//  Created by athos salmeron on 01/09/21.
//

import UIKit

class DetailCell: UITableViewCell {
    @IBOutlet var imgOption: UIImageView!
    @IBOutlet var textOption: UILabel!
    @IBOutlet var CustomInformation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
