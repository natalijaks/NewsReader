//
//  ArticlesCell.swift
//  NewsReader
//
//  Created by Natalija Krsnik on 05/02/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class ArticlesCell: UITableViewCell {

    @IBOutlet var lblDate: UILabel!
    @IBOutlet var imgArticle: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
