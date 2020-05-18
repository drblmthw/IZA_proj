//
//  SearchAndFilter.swift
//  IZA_proj
//
//  Created by Matej Kubový on 18/05/2020.
//  Copyright © 2020 Matej Kubový. All rights reserved.
//

import Foundation


func searchNews(news: [NewsItem], key: String) -> [NewsItem] {
    
    // just basic search with lowercase
    
    var tmpNews: [NewsItem] = []
    
    let lowkey = key.lowercased()
    
    if key == "" {
        return news
    }
    for item in news {
        if item.header.lowercased().contains(lowkey) || item.description.lowercased().contains(lowkey){
            tmpNews.append(item)
        }
    }
    return tmpNews
}


// m̶a̶y̶b̶e̶ ̶n̶e̶x̶t̶ ̶t̶i̶m̶e̶... in future version
func filterNews(news: [NewsItem]) -> [NewsItem] {
    return news
}




