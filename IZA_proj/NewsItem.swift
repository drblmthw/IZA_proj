//
//  NewsItem.swift
//  IZA_proj
//
//  Created by Matej Kubový on 09/05/2020.
//  Copyright © 2020 Matej Kubový. All rights reserved.
//

import Foundation

class NewsItem {
    
    var header: String
    var description: String
    var date: String
    var source: String
    var link: String
    
    init(header: String, description: String, date: String, source: String, link: String) {
        self.header = header
        self.description = description
        self.date = date
        self.source = source
        self.link = link
    }
    
}
