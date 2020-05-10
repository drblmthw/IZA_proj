//
//  NewsCell.swift
//  IZA_proj
//
//  Created by Matej Kubový on 09/05/2020.
//  Copyright © 2020 Matej Kubový. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var itemHeading: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemDate: UILabel!
    @IBOutlet weak var itemSource: UILabel!
    
    // fill in data
    func setItem(item: NewsItem) {
        itemHeading.text = item.header
        itemDescription.text = item.description
        itemDate.text = item.date
        itemSource.text = item.source
    }
    
}
