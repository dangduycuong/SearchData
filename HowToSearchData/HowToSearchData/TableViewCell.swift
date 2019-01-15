//
//  TableViewCell.swift
//  HowToSearchData
//
//  Created by duycuong on 1/15/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var nameImageView: UIImageView!
    @IBOutlet weak var catogeryLabel: UILabel!
    @IBOutlet weak var laptopLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        textLabel?.text = ""
        detailTextLabel?.text = ""
        backgroundColor = UIColor.white
        print("Da reuse chua")
    }

}
