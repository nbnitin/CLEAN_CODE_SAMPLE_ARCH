//
//  UserTableViewCell.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/6/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet var lblName: UILabel!
    @IBOutlet var imgUser: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
