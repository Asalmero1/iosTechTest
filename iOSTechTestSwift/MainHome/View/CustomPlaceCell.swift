//
//  CustomPlaceCell.swift
//  iOSTechTestSwift
//
//  Created by athos salmeron on 30/08/21.
//

import UIKit
import RxSwift
class CustomPlaceCell: UITableViewCell {
    @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var titlePlace: UILabel!
    
    @IBOutlet weak var distancePlace: UILabel!
    @IBOutlet weak var addressPlace: UILabel!
    @IBOutlet weak var imagePetFriendly: UIImageView!
    @IBOutlet weak var petFriendlyTxt: UILabel!
    @IBOutlet weak var distanceTxT: UILabel!
    @IBOutlet var ratingView: StarRatingView!
    public static var SendRating : Float! = 4
    
        
    override func awakeFromNib() {
       
        
        self.ratingView?.rating = CustomPlaceCell.SendRating
        
        
      
        super.awakeFromNib()
        // Initialization code
        imagePlace.clipsToBounds = true
        imagePlace.layer.cornerRadius = 8
       
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
