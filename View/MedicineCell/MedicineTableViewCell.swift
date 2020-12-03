//
//  MedicineTableViewCell.swift
//  Healthera
//
//  Created by Kashan Qamar on 02/12/2020.
//

import UIKit

class MedicineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverImage:UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var statusLabel : UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
