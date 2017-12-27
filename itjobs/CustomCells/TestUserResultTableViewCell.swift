//
//  TestUserResultTableViewCell.swift
//  itjobs
//
//  Created by Piotrek on 27.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class TestUserResultTableViewCell: UITableViewCell {

    @IBOutlet weak var offerTitle: UILabel!
    @IBOutlet weak var companyName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
