//
//  Downloader.swift
//  IZA_proj
//
//  Created by Matej Kubový on 10/05/2020.
//  Copyright © 2020 Matej Kubový. All rights reserved.
//

import Foundation

// delegate protocol
protocol XmlDownloaderDelegate {
    func didFinishDownloading(_ sender:XmlParserManager)
}


class XmlParserManager: NSObject, XMLParserDelegate {
    
    // delegate
    var delegate: XmlDownloaderDelegate?
    
    var parser = XMLParser()
    
    private var element = ""
    
    // flags to check if element is inside item and to avoid elements inside image element
    private var is_in_item = false
    private var is_in_image = false
    
    private var n_header: String = ""
    private var n_description: String = ""
    private var n_date: String = ""
    private var n_link: String = ""
    
    private var tempNews: [NewsItem] = []
    
    private var rss_sources: [String:String] = [:]
    
    private var portal = ""
    
    func downloadNews() -> Void {
        
        // set sources
        let userDefaults = UserDefaults.standard
        // if is this first run of app - set all sources to true
        if !userDefaults.bool(forKey: "NOT_FIRST_RUN") {
            userDefaults.set(true, forKey: "NOT_FIRST_RUN")
            userDefaults.set(true, forKey: "Set_aktuality")
            userDefaults.set(true, forKey: "Set_dennikn")
            userDefaults.set(true, forKey: "Set_sme")
            userDefaults.set(true, forKey: "Set_hnonline")
            userDefaults.set(true, forKey: "Set_pravda")
        }
        
        rss_sources.removeAll()
        
        if userDefaults.bool(forKey: "Set_aktuality") {
            rss_sources["Aktuality"] = "https://www.aktuality.sk/rss/"
        }
        if userDefaults.bool(forKey: "Set_dennikn") {
            rss_sources["Denník N"] = "https://dennikn.sk/feed"
        }
        if userDefaults.bool(forKey: "Set_sme") {
            rss_sources["SME"] = "https://www.sme.sk/rss-title"
        }
        if userDefaults.bool(forKey: "Set_hnonline") {
            rss_sources["HNonline"] = "https://articles.hnonline.sk/feed/rss2?category=hn-881"
        }
        if userDefaults.bool(forKey: "Set_pravda") {
            rss_sources["Pravda"] = "https://spravy.pravda.sk/rss/xml/"
        }
           
        // run async download
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            // clear array
            self.tempNews.removeAll()
            
            for(port, link) in self.rss_sources {
                self.portal = port
                let url = URL(string: link)!
            
                self.parser = XMLParser(contentsOf: url)!
                self.parser.delegate = self
                self.parser.shouldProcessNamespaces = false
                self.parser.shouldReportNamespacePrefixes = false
                self.parser.shouldResolveExternalEntities = false
                self.parser.parse()
            }
            
            
            // call didDownloadXml func
            DispatchQueue.main.async {
                self.didDownloadXml()
            }
        }
    }
    
    func didDownloadXml() {
        // when downloaded, sort by date...
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "sk")
        dateFormatter.dateFormat = "dd/MM/yy HH:mm"
        tempNews.sort(by: {
            let date1 = dateFormatter.date(from:$0.date)!
            let date2 = dateFormatter.date(from:$1.date)!
            if date1 < date2 {
                return false
            }
            else {
                return true
            }
        })
        
        
        //
        delegate?.didFinishDownloading(self)
    }
    
    func getNews() -> [NewsItem] {
        // return news list
        return tempNews
    }
    
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        // set flag if going into image element
        if elementName == "image" {
            is_in_image = true
        }
        
        element = elementName
        
        if element == "item" {
            // clear variables
            n_header = ""
            n_description = ""
            n_date = ""
            n_link = ""
            
            // is inside item element
            is_in_item = true
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // skip elements inside image el.
        if is_in_image == true {
            return
        }
        
        if is_in_item == true {
            if element == "title" {
                n_header.append(string)
            }
            
            if element == "link" {
                n_link.append(string)
            }
            
            if element == "description" {
                n_description.append(string)
            }
            
            if element == "pubDate" {
                n_date.append(string)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        // set flag if going out of image element
        if elementName == "image" {
            is_in_image = false
        }
        
        if elementName == "item" && is_in_item == true {
            
            // format final output
            n_header = formatHeader(header: n_header, portal: portal)
            n_description = formatDescription(description: n_description, portal: portal)
            n_date = formatDate(date: n_date, portal: portal)
            n_link = formatLink(link: n_link, portal: portal)

            if !n_header.isEmpty && !n_link.isEmpty && !n_description.isEmpty && !n_date.isEmpty {
                let tmp_item = NewsItem(header: n_header, description: n_description, date: n_date, source: portal, link: n_link)
                tempNews.append(tmp_item)
            }
        }
        
        if elementName == "item" {
            is_in_item = false
        }
    }
    
}






