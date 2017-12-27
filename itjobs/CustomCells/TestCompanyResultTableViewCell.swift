//
//  TestCompanyResultTableViewCell.swift
//  itjobs
//
//  Created by Piotrek on 27.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class TestCompanyResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cvImage: UIImageView!
    @IBOutlet weak var offerTitle: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var points: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
