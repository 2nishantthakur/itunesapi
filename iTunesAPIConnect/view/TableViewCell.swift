//
//  TableViewCell.swift
//  iTunesAPIConnect
//
//  Created by Nishant Thakur on 04/01/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var trackName: UILabel!
    @IBOutlet var artistName: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
