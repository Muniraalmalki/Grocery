//
//  cell.swift
//  Grocery
//
//  Created by munira almallki on 08/04/1443 AH.
//

import UIKit

class cell: UITableViewCell {

    @IBOutlet weak var namelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var emailLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
