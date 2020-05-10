//
//  Downloader.swift
//  IZA_proj
//
//  Created by Matej Kubový on 10/05/2020.
//  Copyright © 2020 Matej Kubový. All rights reserved.
//

import Foundation

class XmlParserManager: NSObject, XMLParserDelegate {
    
    var url = URL(string: "https://www.aktuality.sk/rss/")!
    
    
    
    
    
}








func getNews() -> [NewsItem] {
    
    
    var tempNews: [NewsItem] = []
    
    var url = URL(string: "https://www.aktuality.sk/rss/")!
    
    
    
    
    
    
    
    
    
    
    
    
    let item1 = NewsItem(header: "Nadpis 1", description: "Tu je umiestnený popis 1", date: "9.5.2020 12:42", source: "SME")
    let item2 = NewsItem(header: "Nadpis 2", description: "Tu je umiestnený popis 2", date: "8.5.2020 12:42", source: "SME")
    let item3 = NewsItem(header: "Nadpis 3", description: "Tu je umiestnený popis 3", date: "7.5.2020 12:42", source: "SME")
    let item4 = NewsItem(header: "Nadpis 4", description: "Tu je umiestnený popis 4", date: "6.5.2020 12:42", source: "SME")
    let item5 = NewsItem(header: "Príliš dlhý nadpis 5, ktorý sa skráti hneď za týmto slovom", description: "Tu je umiestnený príliš dlhý popis 5, ktorý sakhjasf afasfsdg fsdfskdf sdfkjsd df dskf jsfksjdf asda asdka askda dskas dakaks asdkas aksjdhaks ajhs aksdjha dkajs dkajshd akdsjha skajshd aksdjha sk", date: "5.5.2020 12:42", source: "SME")
    
    tempNews.append(item1)
    tempNews.append(item2)
    tempNews.append(item3)
    tempNews.append(item4)
    tempNews.append(item5)
    
    return tempNews
}
